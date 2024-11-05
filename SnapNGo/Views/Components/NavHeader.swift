//
//  NavHeader.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 6/11/2567 BE.
//

import Foundation
import SwiftUI

struct NavHeader: View{
    var scrollOffset: CGFloat
    var title: String
    var icon: String
    var body: some View{
        ZStack{
            Color.clear
                .frame(height: interpolatedHeight())
                .background(.ultraThinMaterial.opacity(opacityView()))
                .blur(radius: 0.5)
                .ignoresSafeArea(edges: .top)
            HStack{
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                    Text("Jane Doe")
                        .font(.system(size: interpolatedText()))
                }
                Spacer()
//                Image(systemName: icon).font(.system(size: iconsize()))
                Image("currency")
                    .resizable()
                    .frame(width: iconWidth(), height: iconHeight())
                    .aspectRatio(contentMode: .fill)
            }
            .offset(y: PushupOffset())
            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
    
    private func interpolatedHeight() -> CGFloat{
        let startHeight: CGFloat = 100
        let endHeight: CGFloat = 85
        let transitionOffset: CGFloat = 10
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return endHeight + (startHeight - endHeight) * progress
    }
    
    private func interpolatedText() -> CGFloat{
        let startOffset: CGFloat = 20
        let endOffset: CGFloat = 30
        let transitionOffset: CGFloat = 50
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return endOffset + (startOffset - endOffset) * progress
    }
    
    private func iconWidth() -> CGFloat{
        let theEnd: CGFloat = 90
        let theStart: CGFloat = 85
        let transitionOffset: CGFloat = 35
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return theEnd + (theStart - theEnd) * progress
    }
    
    private func iconHeight() -> CGFloat{
        let theEnd: CGFloat = 35
        let theStart: CGFloat = 40
        let transitionOffset: CGFloat = 35
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return theEnd + (theStart - theEnd) * progress
    }
    
    private func PushupOffset() -> CGFloat{
        let theEnd: CGFloat = -40
        let theStart: CGFloat = -30
        let transitionOffset: CGFloat = 50
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return theEnd + (theStart - theEnd) * progress
    }
    
    private func opacityView() -> CGFloat{
        let startOffset: CGFloat = 0
        let endOffset: CGFloat = 1
        let transitionOffset: CGFloat = 50
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return endOffset + (startOffset - endOffset) * progress
    }
}

struct CustomNavView<Content: View> : View {
    var title: String
    var icon: String
    let content: Content
    @State private var scrollOffset: CGFloat = 0
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                
                ScrollOffsetBackground{ offset in
                    self.scrollOffset = offset - geo.safeAreaInsets.top
                }
                .frame(height: 0)
                content
            }
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConstants.background)
            .ignoresSafeArea()
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 40)
            })
            .overlay {
                NavHeader(scrollOffset: scrollOffset, title: title, icon: icon)
            }
        }
    }
}

struct ScrollOffsetBackground: View{
    var onOffsetChange: (CGFloat) -> Void
    var body: some View{
        GeometryReader{ geo in
            Color.clear
                .preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).minY)
                .onPreferenceChange(ViewOffsetKey.self, perform: onOffsetChange)
        }
    }
}

struct ViewOffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TestView: View{
    var body: some View{
        CustomNavView(title: "title", icon: "person.circle") {
            ForEach(0..<11){ _ in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 180, height: 170)
                    .foregroundStyle(.blue.gradient)
            }
        }
        .padding(.horizontal, 5)
    }
}

#Preview{
    TestView()
}
