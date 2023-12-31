//
//  RecipesRepository.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct RecipesRepository {
    private let remoteService: RecipesRemoteService
    private let localService: RecipesLocalService
    
    init(remoteService: RecipesRemoteService,
         localService: RecipesLocalService) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func getRecipe(recipeId: Int) async throws -> Recipe {
        do {
            return try await remoteService.getRecipe(recipeId: recipeId)
        } catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func addRecipeToFavorites(recipe: Recipe) {
        localService.addRecipeToFavorites(recipe: recipe)
    }
    
    func getAllFavoriteRecipes() -> [FavoriteRecipe] {
        localService.getAllFavorites()
            .compactMap({ cdFavorite in
                guard let title = cdFavorite.title, let id = cdFavorite.id else { return nil }
                return FavoriteRecipe(title: title, id: id, image: cdFavorite.image ?? "")
            })
    }
    
    func deleteRecipe(recipe: FavoriteRecipe) {
        localService.deleteFavorite(recipe: recipe)
    }
}
