//
//  MainView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 15/12/23.
//

import SwiftUI

struct MainView: View {
    
    private struct Layout {
        static let categoriesListTitle = "Categories"
        static let photoGalleryTitle = "Gallery"
        static let userAccountTitle = "Account"
        static let categoriesListIcon = "fork.knife.circle"
        static let photoGalleryIcon = "photo.fill"
        static let userAccountIcon = "person.fill"
    }
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            coordinator.makeCategoriesView()
                .tabItem {
                    Label(Layout.categoriesListTitle, systemImage: Layout.categoriesListIcon)
                }
            coordinator.makePhotoGalleryView()
                .tabItem {
                    Label(Layout.photoGalleryTitle, systemImage: Layout.photoGalleryIcon)
                }
            coordinator.makeUserMainView()
                .tabItem {
                    Label(Layout.userAccountTitle, systemImage: Layout.userAccountIcon)
                }
        }.accentColor(.darkBlue)
    }
}

#Preview {
    let coordinator = Coordinator()
    
    return MainView()
        .environmentObject(coordinator)
}
