//
//  UserFavoritesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import Toast

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
                if (viewModel.favoritesList.isEmpty) {
                    VStack {
                        Text("No favorites added yet.")
                    }.frame(height: UIScreen.main.bounds.size.height / 2, alignment: .center)
                } else {
                    List {
                        ForEach(viewModel.favoritesList, id: \.id) { favorite in
                            createRow(for: favorite)
                                .frame(maxWidth: .infinity)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        if let index = viewModel.favoritesList.firstIndex(of: favorite) {
                                            viewModel.favoritesList.remove(at: index)
                                            viewModel.deleteFavorite(recipe: favorite)
                                            
                                            Toast.default(
                                                image: UIImage(systemName: "heart")!,
                                                title: "Favorite deleted").show()
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }.toolbar {
                        ToolbarItem {
                            Button(action: {
                                viewModel.deleteAllFavorites()
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .listRowInsets(EdgeInsets())
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
    
    private func createRow(for favorite: FavoriteRecipe) -> some View {
        FavoriteItemView(favoriteItem: favorite)
            .background(
                NavigationLink {
                    coordinator.makeRecipesView(for: favoriteRecipeToMealMapper.mapFavoriteToMeal(favorite: favorite))
                } label: { EmptyView() }
                    .buttonStyle(PlainButtonStyle())
            )
            .buttonStyle(PlainButtonStyle())
            .shadow(color: .gray, radius: 5, x: 3, y: 3)
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeUserFavoritesView().environmentObject(coordinator)
}
