//
//  ScheduleView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI

struct ScheduleView: View {
    
    var title: String
    var day: String
    var massType: String
    var time: String
    
    var body: some View {
        VStack(spacing: Constants.LayoutPadding.small) {
            Text(title)
                .heading2()
                .frame(maxWidth: 220)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            HStack {
                Text(day)
                    .body1()

                Spacer()
                
                Text(massType)
                    .heading2()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Text(time)
                    .body1()
            }
            .padding(.horizontal,Constants.LayoutPadding.medium)
            
            LineView()
        }
    }
}

