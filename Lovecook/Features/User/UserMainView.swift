//
//  UserMainView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/12/23.
//

import SwiftUI

struct UserMainView: View {
    
    private struct Layout {
        static let userAccountTitle = "My account"
        static let pickerTitle = "Choose an option:"
        static let pickerAccountText = "Account Details"
        static let pickerFavoritesText = "My Favorites"
    }
    
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedView = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker(Layout.pickerTitle, selection: $selectedView) {
                    Text(Layout.pickerAccountText).tag(0)
                    Text(Layout.pickerFavoritesText).tag(1)
                }
                .pickerStyle(.segmented)
                
                switch selectedView {
                case 0:
                    coordinator.makeUserAccountView()
                case 1:
                    coordinator.makeUserFavoritesView()
                default:
                    EmptyView()
                }
                Spacer()
            }
            .navigationTitle(Layout.userAccountTitle)
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity)
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return UserMainView()
        .environmentObject(coordinator)
}
