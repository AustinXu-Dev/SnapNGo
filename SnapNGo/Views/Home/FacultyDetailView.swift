//
//  FacultyDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI
import ExpandableText
import Kingfisher

struct FacultyDetailView: View {
    
    var facultyData: FacultyData
    
    var body: some View {
        ScrollView{
            VStack(spacing: Constants.LayoutPadding.small){
                imageSection
                
                bodySection
                
                LinkBoxView(text: "Curious about the programs at \(facultyData.abbreviation)? Hit up this link for all the info:", url: facultyData.link)
                    
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
        HStack{
            if let imageUrl = facultyData.images?.first{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .frame(maxWidth: 120, maxHeight: 120)
                    .aspectRatio(contentMode: .fill)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image("image_placeholder")
                    .resizable()
                    .frame(maxWidth: 120, maxHeight: 120)
                    .aspectRatio(contentMode: .fill)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
    }
    
    private var bodySection: some View{
        VStack(alignment: .leading, spacing: Constants.LayoutPadding.small){
            Text(facultyData.name)
                .heading2()
                .lineLimit(2)
            HStack{
                Image(Constants.DetailView.locationIcon)
                Text(facultyData.location)
                    .body2()
                    .lineLimit(2)
            }
            
            HStack{
                Image(Constants.DetailView.phoneIcon)
                Text(facultyData.contact)
                    .body2()
                    .lineLimit(2)
            }
            
            HStack{
                Image(Constants.DetailView.emailIcon)
                Text(facultyData.socialMedia.email)
                    .body2()
                    .lineLimit(2)
                    .tint(.black)
            }
            
            LineView(horizontalPadding: 0)
            
            ExpandableText(facultyData.longDescription)
                .font(.system(size: 12, weight: .regular))
                .enableCollapse(true)
                .lineLimit(10)

            LineView(horizontalPadding: 0)

            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FacultyDetailView(facultyData: FacultyMockData.Data1)
}

//            ExpandableText("The School of Science and Technology (VMS) is a leader in Computer Science and IT education in Thailand, with programs focused on both technological innovation and practical application. VMS emphasizes active learning, project-based results, and flexible course choices, allowing students to specialize in areas like Software Engineering, Data Science, Network Technology, and Enterprise Systems, with options to study across disciplines for a broader career perspective.")
//                .font(.system(size: 12, weight: .regular))
//                .enableCollapse(true)
//                .lineLimit(6)
