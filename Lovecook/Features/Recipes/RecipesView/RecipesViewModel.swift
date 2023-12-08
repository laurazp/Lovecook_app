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
    
    init(getRecipeUseCase: GetRecipeUseCase) {
        self.getRecipeUseCase = getRecipeUseCase
    }
    
    /*@MainActor
    func getRecipe(meal: meal) async {
        error = nil
        isLoading = true
        
        do {
            let recipe = try await getRecipeUseCase.execute(recipe: meal)
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }*/
}
