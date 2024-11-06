//
//  AboutUsView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 6/11/2567 BE.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 5) {
                    Image("sample")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 116, height: 136)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text("History and Background")
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Founded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .lineLimit(5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Text("Explore More")
                                .font(.footnote)
                        }.buttonStyle(.borderedProminent)

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 370, height: 130)
                .padding(.horizontal, 5)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(12)
                
                AboutUsLongCardView(image: "sample", title: "History and Background", description: "Founded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.") {
                    print("works")
                }

            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationTitle("About Us")
    }
}


#Preview {
    NavigationStack{
        AboutUsView()
    }
}
