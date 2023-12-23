//
//  UserMainView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/12/23.
//

import SwiftUI

struct UserMainView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedView = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Choose an option:", selection: $selectedView) {
                    Text("Account Details").tag(0)
                    Text("My Favorites").tag(1)
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
            .navigationTitle("My account")
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
