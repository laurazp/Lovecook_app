//
//  MealsByCategoryRepository.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct MealsByCategoryRepository {
    private let remoteService: MealsByCategoryRemoteService
    
    init(remoteService: MealsByCategoryRemoteService) {
        self.remoteService = remoteService
    }
    
    func getMealsByCategory(category: Category) async throws -> [Meal] {
        do {
            return try await remoteService.getMealsByCategory(category: category)
        } catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
}
