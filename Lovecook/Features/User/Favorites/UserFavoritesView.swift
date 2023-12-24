//
//  UserFavoritesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI

struct UserFavoritesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: RecipesViewModel
    
    //TODO: borrar al terminar de usar
    var favoritesList: [Recipe]  = [Recipe.example, Recipe.example, Recipe.example, Recipe.example]
    
    init(viewModel: RecipesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(favoritesList, id: \.recipeId /*viewModel.favoritesList*/) { favorite in
                    NavigationLink {
                        Text(favorite.recipeTitle)
                        /*coordinator.makeRecipesView(for: favorite)*/
                    } label: {
                        /*FavoriteItemView(favorite: favorite)*/
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await /*viewModel.*/getFavoritesList()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            await /*viewModel.*/getFavoritesList()
        }
    }
    
    func getFavoritesList() async -> [Recipe] {
        return self.favoritesList
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeUserFavoritesView().environmentObject(coordinator)
}
