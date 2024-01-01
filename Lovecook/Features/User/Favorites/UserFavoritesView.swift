//
//  UserFavoritesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI

struct UserFavoritesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: UserFavoritesViewModel
    @Environment(\.managedObjectContext) var viewContext
    
    private let favoriteRecipeToMealMapper = FavoriteRecipeToMealMapper()
    
    init(viewModel: UserFavoritesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.favoritesList, id: \.id) { favorite in
                        NavigationLink {
                            coordinator.makeRecipesView(for: favoriteRecipeToMealMapper.mapFavoriteToMeal(favorite: favorite))
                        } label: {
                            //TODO: FavoriteItemView(favorite: favorite)
                            Text(favorite.title ?? "Untitled")
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .leading) {
                            Button {
                                if let index = viewModel.favoritesList.firstIndex(of: favorite) {
                                    viewModel.favoritesList.remove(at: index)
                                    viewModel.deleteFavorite(recipe: favorite)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    viewModel.getAllFavorites()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            viewModel.getAllFavorites()
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeUserFavoritesView().environmentObject(coordinator)
}
