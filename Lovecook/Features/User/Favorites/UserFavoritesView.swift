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
    //@EnvironmentObject var persistenceController: CoreDataPersistenceController
    @Environment(\.managedObjectContext) var viewContext
    
    //TODO: hace falta???
    @FetchRequest(entity: CDFavoriteRecipe.entity(), sortDescriptors: []) var favoriteRecipes: FetchedResults<CDFavoriteRecipe>
    
    //private var favorites: FetchedResults<CDFavoriteRecipe>
    
    //TODO: borrar al terminar de usar
    var favoritesList: [Recipe]  = [Recipe.example, Recipe.example, Recipe.example, Recipe.example]
    
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
                            /*coordinator.makeRecipesView(for: favorite)*/
                        } label: {
                            /*FavoriteItemView(favorite: favorite)*/
                            Text(favorite.title ?? "Untitled")
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                
                /*List(favoritesList, id: \.recipeId /*viewModel.favoritesList*/) { favorite in
                    NavigationLink {
                        Text(favorite.recipeTitle)
                        /*coordinator.makeRecipesView(for: favorite)*/
                    } label: {
                        /*FavoriteItemView(favorite: favorite)*/
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }*/
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    //await getFavoritesList()
                    await viewModel.getAllFavorites()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            //await getFavoritesList()
            await viewModel.getAllFavorites()
        }
    }
    
    //TODO: borrar si no sirve!
    func getFavoritesList() async -> [Recipe] {
        return self.favoritesList
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeUserFavoritesView().environmentObject(coordinator)
}
