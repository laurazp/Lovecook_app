//
//  AddRecipeToFavoritesUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 29/12/23.
//

import Foundation
struct AddRecipeToFavoritesUseCase {
    let recipesRepository: RecipesRepository

    func execute(for recipe: Recipe) {
        recipesRepository.addRecipeToFavorites(recipe: recipe)
    }
}
