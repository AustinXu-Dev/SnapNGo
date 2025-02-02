//
//  QRCodeGenerator.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/2.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
import RealmSwift

// Generate QR Code from a string
func generateQRCode(from text: String) -> UIImage? {
    let filter = CIFilter.qrCodeGenerator()
    let data = Data(text.utf8)
    filter.setValue(data, forKey: "inputMessage")

    if let ciImage = filter.outputImage {
        let context = CIContext()
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
    }
    return nil
}

// Convert UIImage to Data
func convertImageToData(_ image: UIImage) -> Data? {
    return image.pngData()
}

// Save QR Code to Realm
func saveQRCodeToRealm(teamId: String, image: UIImage) {
    guard let imageData = convertImageToData(image) else { return }
    let qrCode = QRCodeModel(teamId: teamId, qrData: imageData)
    
    let realm = try! Realm()
    try! realm.write {
        realm.add(qrCode, update: .modified)
    }
}

// Retrieve QR Code from Realm
func fetchQRCode(teamId: String) -> UIImage? {
    let realm = try! Realm()
    if let qrCode = realm.object(ofType: QRCodeModel.self, forPrimaryKey: teamId) {
        return UIImage(data: qrCode.qrData)
    }
    return nil
}
