//
//  MealsByCategoryViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import Foundation

class MealsByCategoryViewModel: ObservableObject {
    
    private let getMealsByCategoryUseCase: GetMealsByCategoryUseCase
    @Published var mealsByCategory = [Meal]()
    @Published var isLoading = false
    @Published var error: Error?
    
    init(getMealsByCategoryUseCase: GetMealsByCategoryUseCase) {
        self.getMealsByCategoryUseCase = getMealsByCategoryUseCase
    }
    
    @MainActor
    func getMealsByCategory(category: Category) async {
        error = nil
        isLoading = true
        
        do {
            mealsByCategory = try await getMealsByCategoryUseCase.execute(for: category)
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
