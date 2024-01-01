//
//  CheckFavoriteAddedUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 1/1/24.
//

import Foundation

struct CheckFavoriteAddedUseCase {
    let recipesRepository: RecipesRepository

    func checkFavorite(recipeTitle: String) -> Bool {
        var isAlreadyInFavorites = false
        let favorites = recipesRepository.getAllFavoriteRecipes()
        for favorite in favorites {
            if (favorite.title == recipeTitle) {
                isAlreadyInFavorites = true
            }
        }
        return isAlreadyInFavorites
    }
}
