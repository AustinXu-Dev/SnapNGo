//
//  CreateQRCodeView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/2.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct CreateQRCodeView: View {
    var teamId: String
    @State private var qrImage: UIImage?

    var body: some View {
        VStack {
            if let image = qrImage {
                Image(uiImage: image)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            let joinLink = "https://snap-n-go.vercel.app/api/team/join?teamId=\(teamId)"
            if let storedQR = fetchQRCode(teamId: teamId) {
                qrImage = storedQR
            } else if let newQR = generateQRCode(from: joinLink) {
                qrImage = newQR
                saveQRCodeToRealm(teamId: teamId, image: newQR)
            }
        }
    }
}

//struct CreateQRCodeView: View {
//    @State var joinLink = "https://www.google.com"
//
//    var body: some View {
//        generateQRCode(from: joinLink)
//            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//    }
//
//    func generateQRCode(from text: String) -> Image {
//        let ciContext = CIContext()
//
//        guard let data = text.data(using: .ascii, allowLossyConversion: false) else {
//            return Image(systemName: "exclamationmark.octagon")
//
//        }
//        let filter = CIFilter.qrCodeGenerator()
//        filter.message = data
//
//        if let ciImage = filter.outputImage {
//            if let cgImage = ciContext.createCGImage(
//                ciImage,
//                from: ciImage.extent) {
//
//                return Image(uiImage: UIImage(cgImage: cgImage))
//            }
//        }
//        return Image(systemName: "exclamationmark.octagon")
//
//    }
//}
