//
//  AddRecipeToFavoritesUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 29/12/23.
//

import Foundation

struct DeleteFavoriteRecipeUseCase {
    let recipesRepository: RecipesRepository

    func execute(for recipe: FavoriteRecipe) {
        recipesRepository.deleteRecipe(recipe: recipe)
    }
}
