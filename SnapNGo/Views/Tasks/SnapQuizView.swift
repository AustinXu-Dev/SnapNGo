import SwiftUI
import CoreML
import CoreImage

struct SnapQuizView: View {
    @State private var image: UIImage?
    @State private var target: String = ""
    @State private var targetProbability: [String: Double] = [:]
    @State private var showingImagePicker = false
    @State private var isCamera = false // To toggle between camera and photo library
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: Constants.LayoutPadding.medium){
                    LineView()
                    Spacer()
                        .frame(height: 40)
                    Text("Capture the Photo of CL Building")
                        .heading1()
                    
                    Image("cl_building")
                        .resizable()
                        .frame(width: 299, height: 299)
                        .scaledToFill()
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Button {
                        showingImagePicker = true
                    } label: {
                        Text("Snap")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .frame(height: 36)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Captured Object: \(target)")
                    //                Text("Probabilities: \(targetProbability.description)")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationTitle("Snap Time")
        .fullScreenCover(isPresented: $showingImagePicker) {
            ImagePicker(image: $image, sourceType: .camera)
        }
        .onChange(of: image) { oldImage, newImage in
            if let newImage = newImage {
                // Resize the image to 299x299 pixels
                if let resizedImage = newImage.resized(toSquare: 299) {
                    // Convert the resized image to CVPixelBuffer
                    if let pixelBuffer = resizedImage.pixelBuffer(width: 299, height: 299) {
                        do {
                            // Load the model and make a prediction
                            let model = try SnapClassifier(configuration: MLModelConfiguration())
                            if let prediction = try? model.prediction(image: pixelBuffer) {
                                // Get the predicted class and its confidence score
                                let predictedClass = prediction.target
                                let confidence = prediction.targetProbability[predictedClass] ?? 0.0
                                
                                // Sort the targetProbability dictionary by confidence scores
                                let sortedPredictions = prediction.targetProbability.sorted { $0.value > $1.value }
                                
                                // Display the top 3 predictions
                                let topPredictions = sortedPredictions.prefix(3)
                                
                                // Update the UI
                                if confidence > 0.8 {
                                    target = predictedClass
                                    targetProbability = Dictionary(uniqueKeysWithValues: Array(topPredictions))
                                } else {
                                    target = "Uncertain (Low Confidence)"
                                    targetProbability = [:]
                                }
                            }
                        } catch {
                            print("Error loading model: \(error)")
                        }
                    }
                }
            }
        }
    }
}
