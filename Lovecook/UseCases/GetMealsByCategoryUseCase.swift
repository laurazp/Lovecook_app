//
//  GetMealsByCategoryUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import Foundation

struct GetMealsByCategoryUseCase {
    let mealsByCategoryRepository: MealsByCategoryRepository
    
    func execute(for category: Category) async throws -> [Meal] {
        try await mealsByCategoryRepository.getMealsByCategory(category: category)
    }
}
