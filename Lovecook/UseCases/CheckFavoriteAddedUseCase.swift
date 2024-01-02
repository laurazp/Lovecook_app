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
        let favorites = recipesRepository.getAllFavoriteRecipes()
        return favorites.contains { $0.title == recipeTitle }
    }
}
