//
//  GetRecipeUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct GetRecipeUseCase {
    let recipesRepository: RecipesRepository
    
    func execute(recipeId: Int) async throws -> Recipe {
        try await recipesRepository.getRecipe(recipeId: recipeId)
    }
}
