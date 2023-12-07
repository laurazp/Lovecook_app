//
//  RecipesRemoteService.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct RecipesRemoteService {
    
    let networkClient: URLSessionNetworkClient
    
    init(networkClient: URLSessionNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getRecipe(recipe: Recipe) async throws -> [Recipe] {
        let queryParams = ["i": "\(recipe.idMeal)"]
        
        let response: APIResponse<Recipe> = try await networkClient.getCall(url: NetworkConstants.recipeNetworkUrl, queryParams: queryParams)
        return response.results
    }
}
