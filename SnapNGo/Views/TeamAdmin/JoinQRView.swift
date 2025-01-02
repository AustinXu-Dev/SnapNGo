//
//  JoinQRView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/2.
//

import SwiftUI

struct JoinQRView: View {
    
    var link: String
    
    var body: some View {
        VStack {
            Text("Display qr code")
                .font(.title)
                .bold()
            
            CreateQRCodeView(joinLink: link)
            
            Text("Scan the code above to vist my website.")
        }
    }
}

#Preview {
    JoinQRView(link: "https://www.google.com")
}
