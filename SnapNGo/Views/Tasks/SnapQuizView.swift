import SwiftUI
import CoreML
import CoreImage

struct SnapQuizView: View {
    
    var questionNo: Int
    var snapQuizData: SnapQuiz
    var taskId: String
    var hint: String
    
    @State private var vStackHeight: CGFloat = 0
    @State private var image: UIImage?
    @State private var target: String = ""
    @State private var targetProbability: [String: Double] = [:]
    @State private var showingImagePicker = false
    
    @State private var isAnswerCorrect: Bool = false
    @State private var isShowingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @StateObject private var snapQuizViewModel = SnapQuizCompletionViewModel()
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: Constants.LayoutPadding.medium){
                    
                    LineView()
                    Spacer()
                        .frame(height: 40)
                    
                    quizQuestionView
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 299, height: 299)
                            .scaledToFill()
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    HStack{
                        if image == nil{
                            Button {
                                showingImagePicker = true
                            } label: {
                                Text("Capture")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .frame(height: 36)
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }
                        } else {
                            Button {
                                showingImagePicker = true
                            } label: {
                                Text("Capture")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .frame(height: 36)
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }
                            
                            Button {
                                validate()
                            } label: {
                                Text("Use Photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .frame(height: 36)
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
//                    Text("Captured Object: \(target)")
                    //                Text("Probabilities: \(targetProbability.description)")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if snapQuizViewModel.isLoading{
                loadingBoxView(message: "Submitting answer")
            }
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
                                    if target == snapQuizData.quizName{
                                        isAnswerCorrect = true
                                    }
                                    targetProbability = Dictionary(uniqueKeysWithValues: Array(topPredictions))
                                } else {
                                    target = "Uncertain (Low Confidence)"
                                    isAnswerCorrect = false
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
        .alert(isPresented: $isShowingAlert) {
//            if isAnswerCorrect {
                return Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"), action: {
                        // API call here
                        guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                            print("Error here")
                            return
                        }
                        snapQuizViewModel.checkQuizAnswer(userId: userId, taskId: taskId, selectedAnswer: target){
                            getOneUserVM.userData = snapQuizViewModel.userData
                            AppCoordinator.pop()
                        }
                    })
                )
//            } else {
//                return Alert(
//                    title: Text(alertTitle),
//                    message: Text(alertMessage),
//                    primaryButton: .default(Text("Try Again"), action: {
//                        // Add retry action here
//                        image = nil
//                    }),
//                    secondaryButton: .cancel(Text("Cancel"))
//                )
//            }
        }
        
    }
    
    private var quizQuestionView: some View{
        ZStack{
            Image("snap_icon")
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y: -vStackHeight / 2)
                .zIndex(1)
            
            VStack(alignment: .center, spacing: 8){
                Spacer()
                    .frame(height: 40)
                Text("Snap Quiz \(questionNo)")
                    .heading1()
                Text("Capture the image of \(snapQuizData.quizName).")
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                    .body1()
                Text("hint: It can be found \(hint)")
                    .multilineTextAlignment(.center)
                    .body1()
                    .frame(width: 200)
                Spacer()
                    .frame(height: 20)
            }
            .frame(maxWidth: .infinity, minHeight: 100)

            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            vStackHeight = geometry.size.height
                        }
                        .onChange(of: geometry.size.height) { _, newHeight in
                            vStackHeight = newHeight
                        }
                }.background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                )
            )
        }
        .frame(maxWidth: .infinity)
    }
    
    private func validate(){
        if snapQuizData.quizName.lowercased() == target.lowercased(){
            isAnswerCorrect = true
            alertTitle = "Correct!"
            alertMessage = "Yay! You captured it correctly."
        } else {
            isAnswerCorrect = false
            alertTitle = "Oops!"
            alertMessage = "You captured it wrong, please try again."
        }
        isShowingAlert = true
    }
}
