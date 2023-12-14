//
//  LovecookApp.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct LovecookApp: App {
    let coordinator = Coordinator()
    //let persistenceController = PersistenceController.shared
    
    // Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
