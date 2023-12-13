//
//  RecipesViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 8/12/23.
//

import Foundation

class RecipesViewModel: ObservableObject {
    
    private let getRecipeUseCase: GetRecipeUseCase
    @Published var isLoading = false
    @Published var error: Error?
    var recipe: Recipe?
    
    init(getRecipeUseCase: GetRecipeUseCase) {
        self.getRecipeUseCase = getRecipeUseCase
    }
    
    @MainActor
    func getRecipe(mealId: Int) async {
        error = nil
        isLoading = true
        
        do {
            recipe = try await getRecipeUseCase.execute(recipeId: mealId)
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
