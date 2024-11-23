//
//  QRCodeView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 15/11/2567 BE.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    @AppStorage("link") private var websiteLink = "https://www.google.com"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Link", text: $websiteLink)
                
                Image(uiImage: generateQRCode(from: websiteLink))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .navigationTitle("Your code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRCodeView()
}
