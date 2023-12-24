//
//  MainView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 15/12/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            coordinator.makeCategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "fork.knife.circle")
                }
            coordinator.makeGalleryView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            coordinator.makeUserMainView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }.accentColor(.darkBlue)
    }
}

#Preview {
    let coordinator = Coordinator()

    return MainView()
        .environmentObject(coordinator)
}
