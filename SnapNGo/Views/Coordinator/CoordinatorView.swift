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
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.tab)
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
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
