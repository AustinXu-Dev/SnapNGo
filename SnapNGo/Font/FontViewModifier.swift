//
//  FontViewModifier.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/13.
//

import Foundation
import SwiftUI

struct Heading1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold))
    }
}

struct Heading2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
    }
}

struct Heading3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .semibold))
    }
}

struct Body1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
    }
}

struct Body2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .regular))
    }
}


extension View {
    func heading1() -> some View {
        modifier(Heading1())
    }
    
    func heading2() -> some View {
        modifier(Heading2())
    }
    
    func heading3() -> some View {
        modifier(Heading3())
    }
    
    func body1() -> some View{
        modifier(Body1())
    }
    
    func body2() -> some View{
        modifier(Body2())
    }
}
