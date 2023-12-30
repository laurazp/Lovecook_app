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
    
    init(getRecipeUseCase: GetRecipeUseCase, addRecipeToFavoritesUseCase: AddRecipeToFavoritesUseCase) {
        self.getRecipeUseCase = getRecipeUseCase
        self.addRecipeToFavoritesUseCase = addRecipeToFavoritesUseCase
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
        addRecipeToFavoritesUseCase.execute(for: recipe)
    }
    
    func getFavIconForegroundColor(isFavorite: Bool) -> Color {
        if (isFavorite) {
            return Color.pink
        } else {
            return Color.gray
        }
    }
}
