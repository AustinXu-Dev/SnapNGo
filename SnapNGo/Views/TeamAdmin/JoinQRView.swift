//
//  JoinQRView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/2.
//

import SwiftUI

struct JoinQRView: View {
    
    var teamId: String
    
    var body: some View {
        VStack {
            Text("Display qr code")
                .font(.title)
                .bold()
            
            CreateQRCodeView(teamId: teamId)
            
            Text("Scan the code above to vist my website.")
        }
    }
}

#Preview {
    JoinQRView(teamId: "https://www.google.com")
}
