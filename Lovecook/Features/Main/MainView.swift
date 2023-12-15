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
            //coordinator.makeHomeView()
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            coordinator.makeCategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet")
                }
            //coordinator.makeFavoritesView()
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    let coordinator = Coordinator()

    return MainView()
        .environmentObject(coordinator)
}
