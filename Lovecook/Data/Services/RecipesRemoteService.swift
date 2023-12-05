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
        let response: APIResponse<Recipe> = try await networkClient.get(url: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipe.idMeal)")
        return response.results!
    }
}
