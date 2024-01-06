//
//  RecipesRemoteService.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct RecipesRemoteService {
    
    let networkClient: URLSessionNetworkClient
    let apiRecipeToRecipeMapper: ApiRecipeToRecipeMapper
    
    init(networkClient: URLSessionNetworkClient, apiRecipeToRecipeMapper: ApiRecipeToRecipeMapper) {
        self.networkClient = networkClient
        self.apiRecipeToRecipeMapper = apiRecipeToRecipeMapper
    }
    
    func getRecipe(recipeId: Int) async throws -> Recipe {
        let queryParams = ["i": "\(recipeId)"]
        
        let response: RecipeResponse = try await networkClient.getCall(url: NetworkConstants.recipeNetworkUrl, queryParams: queryParams)
        
        let mappedRecipe = apiRecipeToRecipeMapper.mapToRecipe(apiRecipe: response.meals[0])
        
        return mappedRecipe
    }
}
