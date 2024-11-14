//
//  FacultyDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI
import ExpandableText

struct FacultyDetailView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: Constants.LayoutPadding.small){
                imageSection
                
                bodySection
                
                LinkBoxView(text: "Curious about the programs at VMES? Hit up this link for all the info:", url: "https://vmes.au.edu")
                    
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(Constants.LayoutPadding.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .ignoresSafeArea(edges: .horizontal)
    }
    
    // MARK: - Image Section
    private var imageSection: some View{
        HStack(spacing: 16) {
            Image("sample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Spacer()
            Image("sample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 210, height: 120)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var bodySection: some View{
        VStack(alignment: .leading, spacing: Constants.LayoutPadding.small){
            Text("Vincent Mary School of Engineering, Science & Technology")
                .heading2()
                .lineLimit(2)
            HStack{
                Image(Constants.DetailView.locationIcon)
                Text("Suvarnabhumi Campus")
                    .body2()
                    .lineLimit(2)
            }
            
            HStack{
                Image(Constants.DetailView.phoneIcon)
                Text("(66) 0-2723-231")
                    .body2()
                    .lineLimit(2)
            }
            
            HStack{
                Image(Constants.DetailView.emailIcon)
                Text("vmes@au.edu")
                    .body2()
                    .lineLimit(2)
                    .tint(.black)
            }
            
            LineView(horizontalPadding: 0)
            
            ExpandableText("The School of Engineering (VME) at Assumption University, established in 1990, is known for producing top engineers and innovative advancements. Initially offering Electrical and Electronics Engineering, it expanded in 2005 to include Computer, Mechatronics, and Telecommunication Engineering, and added Aeronautics and Aircraft Maintenance in 2015. Today, VME offers five specialized programs across Aeronautics, Electrical and Computer, and Mechatronics Engineering.")
                .font(.system(size: 12, weight: .regular))
                .enableCollapse(true)
                .lineLimit(6)
            ExpandableText("The School of Science and Technology (VMS) is a leader in Computer Science and IT education in Thailand, with programs focused on both technological innovation and practical application. VMS emphasizes active learning, project-based results, and flexible course choices, allowing students to specialize in areas like Software Engineering, Data Science, Network Technology, and Enterprise Systems, with options to study across disciplines for a broader career perspective.")
                .font(.system(size: 12, weight: .regular))
                .enableCollapse(true)
                .lineLimit(6)

            
            LineView(horizontalPadding: 0)

            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FacultyDetailView()
}
