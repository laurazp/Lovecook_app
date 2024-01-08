//
//  LovecookApp.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import GoogleSignIn
import CoreData

@main
struct LovecookApp: App {
    let coordinator = Coordinator()
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(coordinator)
                .environmentObject(viewModel)
        }
    }
}

extension LovecookApp {
    private func setupFirebase() {
        FirebaseApp.configure()
    }
}
