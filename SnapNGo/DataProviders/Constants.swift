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
    
    struct DetailView{
        static let locationIcon = "location_icon"
        static let phoneIcon = "phone_icon"
        static let emailIcon = "email_icon"
        static let massScheduleText = "Mass Schedule"
    }
    
    struct TeamViewConstant{
        static let teamHomeImage = "join_team_image"
        static let logo = "logo"
        static let welcomeMessage = "Looks like you haven't hopped on the team train!"
        static let description = "Scan the QR code to join the fun!"
        static let joinButtonText = "Scan QR code"
        static let participantIcon = "participant_icon"
    }
    
    struct CreateTeamViewConstant{
        static let createTeamPreScreenImage = "team_home_image"
        static let createTeamImage = "create_team_image"
        static let logo = "logo"
        static let welcomeMessage = "Welcome to SnapNGo!"
        static let description = "Ready to Snap and Explore?\nLet's make campus tour an unforgettable adventure.\nCreate Team and let them start the journey now!"
        static let createButtonText = "Create Team"
        static let createTeamSubtitle = "Create a Team.\nShow the students the QR Code.\nLet them scan it\nStart the journey!"
        static let teamImageTitle = "Team Image"
        static let chooseLocationsTitle = "Choose the locations (Maximum Location: 5)"
        static let createQrButtonText = "Create QR"
        static let scanQrText = "Scan QR code to Join the Team"
        
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
        static let nameTitle = "Name"
        static let schoolTitle = "Name of the School"
        static let passwordTitle = "Password"
        static let confirmPasswordTitle = "Confirm Password"
        static let emailPlaceholder = "enter email address"
        static let namePlaceholder = "Jane Doe"
        static let schoolPlaceholder = "For Example: Assumption Unviersity of Thailand"
        static let passwordPlaceholder = "enter password"
        static let confirmPasswordPlaceholder = "confirm password"
        static let noAccountText = "Don't have an account yet?"
        static let haveAccountText = "Already have an account?"
        static let signInText = "Sign In"
        static let signUpText = "Sign Up"
    }
    
    struct MapViewConstant{
        static let sheetTitle = "Where do you want to go?"
        static let useCurrentLocation = "Use Current Location"
        static let startLocation = "Start Location"
        static let endLocation = "End Location"
        static let showMeButtonText = "Show me the way"
    }
}
