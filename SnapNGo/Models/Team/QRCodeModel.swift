//
//  QRCodeModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/2.
//

import Foundation
import RealmSwift

class QRCodeModel: Object, Identifiable {
    @Persisted(primaryKey: true) var teamId: String
    @Persisted var qrData: Data // Store QR code as Data
    @Persisted var createdAt: Date = Date()

    convenience init(teamId: String, qrData: Data) {
        self.init()
        self.teamId = teamId
        self.qrData = qrData
    }
}
