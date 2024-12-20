//
//  AppDelegate.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 3/11/2567 BE.
//

import Foundation
import GoogleSignIn
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    //MARK: - Initializing code for Firebase (App Configuration)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    //MARK: - Handle the URL that application receives at the end of the authentication process
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
