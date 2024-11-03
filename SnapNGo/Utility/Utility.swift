//
//  Utility.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 3/11/2567 BE.
//

import Foundation
import UIKit

final class Application_utility {
    
    static var rootViewController: UIViewController{
        
        //MARK: - View will lead to the google sign-in link got from Firebase
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
