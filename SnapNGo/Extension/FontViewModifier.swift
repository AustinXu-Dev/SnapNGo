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

struct Body1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .regular))
    }
}


extension View {
    func heading1() -> some View {
        modifier(Heading1())
    }
    func body1() -> some View{
        modifier(Body1())
    }
}
