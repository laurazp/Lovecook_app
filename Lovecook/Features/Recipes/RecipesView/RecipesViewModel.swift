//
//  RecipesViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 8/12/23.
//

import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    
    var recipe: Recipe?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let getRecipeUseCase: GetRecipeUseCase
    private let addRecipeToFavoritesUseCase: AddRecipeToFavoritesUseCase
    private let deleteFavoriteRecipeUseCase: DeleteFavoriteRecipeUseCase
    private let checkFavoriteAddedUseCase: CheckFavoriteAddedUseCase
    
    init(getRecipeUseCase: GetRecipeUseCase, addRecipeToFavoritesUseCase: AddRecipeToFavoritesUseCase, deleteFavoriteRecipeUseCase: DeleteFavoriteRecipeUseCase, checkFavoriteAddedUseCase: CheckFavoriteAddedUseCase) {
        self.getRecipeUseCase = getRecipeUseCase
        self.addRecipeToFavoritesUseCase = addRecipeToFavoritesUseCase
        self.deleteFavoriteRecipeUseCase = deleteFavoriteRecipeUseCase
        self.checkFavoriteAddedUseCase = checkFavoriteAddedUseCase
    }
    
    @MainActor
    func getRecipe(mealId: Int) async {
        error = nil
        isLoading = true
        
        do {
            recipe = try await getRecipeUseCase.execute(recipeId: mealId)
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
    func addRecipeToFavorites(recipe: Recipe) {
        if (checkFavoriteAddedUseCase.checkFavorite(recipeTitle: recipe.recipeTitle)) {
            //TODO: mostrar snackBar avisando que ya está añadido ??
            print("Recipe is already added to Favorites!")
            return
        } else {
            addRecipeToFavoritesUseCase.execute(for: recipe)
        }
    }
    
    func deleteRecipeFromFavorites(recipe: Recipe) {
        let favoriteToDelete = FavoriteRecipe(
            title: recipe.recipeTitle,
            id: recipe.id,
            image: recipe.recipeImage)
        
        deleteFavoriteRecipeUseCase.execute(for: favoriteToDelete)
    }
    
    func getFavIconForegroundColor(recipe: Recipe, isFavorite: Bool) -> Color {
        return if checkFavoriteAddedUseCase.checkFavorite(recipeTitle: recipe.recipeTitle) || isFavorite {
            Color.pink
        } else {
            Color.gray
        }
    }
    
    func checkIfFavorite(meal: Meal) -> Bool {
        return checkFavoriteAddedUseCase.checkFavorite(recipeTitle: meal.mealTitle)
    }
}
