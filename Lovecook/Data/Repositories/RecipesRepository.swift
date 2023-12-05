//
//  RecipesRepository.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct RecipesRepository {
    private let remoteService: RecipesRemoteService
    
    init(remoteService: RecipesRemoteService) {
        self.remoteService = remoteService
    }
    
    func getRecipe(recipe: Recipe) async throws -> Recipe {
        do {
            return try await remoteService.getRecipe(recipe: recipe)[0]
        } catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
}
