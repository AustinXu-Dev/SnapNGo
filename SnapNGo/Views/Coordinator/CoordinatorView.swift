//
//  CoordinatorView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import Foundation
import SwiftUI

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinatorImpl = AppCoordinatorImpl()
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    
    //reterives from local app storage
    private var appState: AppState {
        get { AppState(rawValue: userAppState) ?? .notSignedIn }
        set { userAppState = newValue.rawValue }
    }

    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            switch appState {
            case .signedIn:
                appCoordinator.build(.tab)
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            case .notSignedIn:
                appCoordinator.build(.signIn)
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            }
//                .sheet(item: $appCoordinator.sheet) { sheet in
//                    appCoordinator.build(sheet)
//                }
//                .fullScreenCover(item: $appCoordinator.fullScreenCover) { fullScreenCover in
//                    appCoordinator.build(fullScreenCover)
//                }
        }
        .environmentObject(appCoordinator)
    }
}
