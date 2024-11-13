//
//  Constants.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/2.
//

import Foundation
import SwiftUI

struct Constants{
    struct MyTasks{
        static let title = "My Tasks"
        static let progressLabel = "Progress"
        static let teamEmptyTitle = "Your Team is Empty"
        static let teamEmptyDesc = "Scan the QR code to become part of the team!"
        static let scanButtonText = "Scan"
    }
    
    struct HomeView {
        static let mapTitle = "Our map"
        static let mapNavigateButtonText = "Navigate your next location"
    }
    
    struct TeamViewConstant{
        static let teamHomeImage = "join_team_image"
        static let logo = "logo"
        static let welcomeMessage = "Looks like you haven't hopped on the team train!"
        static let description = "Scan the QR code to join the fun!"
        static let joinButtonText = "Scan QR code"
        static let participantIcon = "participant_icon"
    }
    
    
    struct LayoutPadding{
        static let xsmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xLarge: CGFloat = 32
    }
    
    struct AuthenticationViewConstant{
        static let emailTitle = "Email"
        static let passwordTitle = "Password"
        static let confirmPasswordTitle = "Confirm Password"
        static let emailPlaceholder = "enter email address"
        static let passwordPlaceholder = "enter password"
        static let confirmPasswordPlaceholder = "eonfirm password"
        static let noAccountText = "Don't have an account yet?"
        static let haveAccountText = "Already have an account?"
        static let signInText = "Sign In"
        static let signUpText = "Sign Up"
    }
}
