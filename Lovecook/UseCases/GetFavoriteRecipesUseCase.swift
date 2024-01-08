//
//  AddRecipeToFavoritesUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 29/12/23.
//

import Foundation

struct GetFavoriteRecipesUseCase {
    let recipesRepository: RecipesRepository
    
    func execute() -> [FavoriteRecipe] {
        recipesRepository.getAllFavoriteRecipes()
    }
}
