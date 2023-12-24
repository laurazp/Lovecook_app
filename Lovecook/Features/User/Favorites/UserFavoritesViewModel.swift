//
//  UserFavoritesViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/12/23.
//

import Foundation

class UserFavoritesViewModel: ObservableObject {
    
    //TODO: --- private let getFavoritesUseCase: GetFavoritesUseCase
    @Published var favoritesList = [Recipe]()
    @Published var isLoading = false
    @Published var error: Error?
    
    /*init(getFavoritesUseCase: GetFavoritesUseCase) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }*/
    
    @MainActor
    func getFavorites() {
        error = nil
        isLoading = true
        
        do {
            //TODO: --- mealsByCategory = try getFavoritesUseCase.execute()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
