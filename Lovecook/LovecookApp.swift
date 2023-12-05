//
//  LovecookApp.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI

@main
struct LovecookApp: App {
    let coordinator = Coordinator()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
