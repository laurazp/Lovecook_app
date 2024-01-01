//
//  UserFavoritesViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/12/23.
//

import Foundation

class UserFavoritesViewModel: ObservableObject {
    
    //TODO: --- private let getFavoritesUseCase: GetFavoritesUseCase
    @Published var favoritesList = [CDFavoriteRecipe]()
    @Published var isLoading = false
    @Published var error: Error?
    
    /*init(getFavoritesUseCase: GetFavoritesUseCase) {
     self.getFavoritesUseCase = getFavoritesUseCase
     }*/
    
    //@MainActor
    func getAllFavorites() {
        //TODO: favorites = try getFavoritesUseCase.execute() ??
        //TODO: gestionar carga o errores?
        
        favoritesList =  CoreDataPersistenceController.shared.getAllFavorites()
    }
    
    func addFavorite(recipe: Recipe) {
        CoreDataPersistenceController.shared.addRecipeToFavorites(recipe: recipe)
        getAllFavorites()
    }
    
    func deleteFavorite(recipe: Recipe) {
        CoreDataPersistenceController.shared.deleteFavorite(recipe: recipe)
        getAllFavorites()
    }
}
