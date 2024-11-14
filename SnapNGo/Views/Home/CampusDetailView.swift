//
//  CampusDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI

struct CampusDetailView: View {
    var body: some View {
        ScrollView{
            VStack{
                DetailCardView(image: "sample", title: "Huamak Campus", location: "592/3 Ramkhamhaeng 24, HuaMak, \nBangkapi Bangkok 10240 Thailand", description: "The Chapel of the Annunciation at Assumption University, built in 1984 under the leadership of Rev. Bro. Prateep M. Komolmas with funding from MISSIO, Germany, was blessed by Pope John Paul II and consecrated by Cardinal Meechai Kijboonchu. It serves as a space for prayer, reflection, and religious services for students, faculty, and the local community, including non-Christian visitors.")
                
                LineView(horizontalPadding: 0)
                
                
                DetailCardView(image: "sample", title: "Huamak Campus", location: "592/3 Ramkhamhaeng 24, HuaMak, \nBangkapi Bangkok 10240 Thailand", description: "The Chapel of the Annunciation at Assumption University, built in 1984 under the leadership of Rev. Bro. Prateep M. Komolmas with funding from MISSIO, Germany, was blessed by Pope John Paul II and consecrated by Cardinal Meechai Kijboonchu. It serves as a space for prayer, reflection, and religious services for students, faculty, and the local community, including non-Christian visitors.")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Constants.LayoutPadding.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .ignoresSafeArea(edges: .horizontal)
    }
}

#Preview {
    CampusDetailView()
}
