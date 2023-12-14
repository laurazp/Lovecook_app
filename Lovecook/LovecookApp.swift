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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct LovecookApp: App {
    let coordinator = Coordinator()
    //let persistenceController = PersistenceController.shared
    
    // Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(coordinator)
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension LovecookApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
