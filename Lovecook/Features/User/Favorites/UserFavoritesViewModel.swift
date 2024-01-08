//
//  UserFavoritesViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/12/23.
//

import Foundation

class UserFavoritesViewModel: ObservableObject {
    
    private let getFavoritesUseCase: GetFavoriteRecipesUseCase
    private let addRecipeToFavoritesUseCase: AddRecipeToFavoritesUseCase
    private let deleteFavoriteRecipeUseCase: DeleteFavoriteRecipeUseCase
    @Published var favoritesList = [FavoriteRecipe]()
    @Published var isLoading = false
    @Published var error: Error?
    
    init(getFavoritesUseCase: GetFavoriteRecipesUseCase,
         addRecipeToFavoritesUseCase: AddRecipeToFavoritesUseCase,
         deleteFavoriteRecipeUseCase: DeleteFavoriteRecipeUseCase) {
        self.getFavoritesUseCase = getFavoritesUseCase
        self.addRecipeToFavoritesUseCase = addRecipeToFavoritesUseCase
        self.deleteFavoriteRecipeUseCase = deleteFavoriteRecipeUseCase
    }
    
    func getAllFavorites() {
        favoritesList =  getFavoritesUseCase.execute()
    }
    
    func addFavorite(recipe: Recipe) {
        addRecipeToFavoritesUseCase.execute(for: recipe)
        getAllFavorites()
    }
    
    func deleteFavorite(recipe: FavoriteRecipe) {
        deleteFavoriteRecipeUseCase.execute(for: recipe)
        getAllFavorites()
    }
    
    func deleteAllFavorites() {
        for favorite in favoritesList {
            deleteFavorite(recipe: favorite)
        }
        favoritesList.removeAll()
        getAllFavorites()
    }
}
