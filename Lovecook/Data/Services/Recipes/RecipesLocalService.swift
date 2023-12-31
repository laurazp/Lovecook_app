//
//  RecipesLocalService.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 29/12/23.
//

import Foundation
import SwiftUI

struct RecipesLocalService {
    private let persistanceController: CoreDataPersistenceController
    
    init(persistanceController: CoreDataPersistenceController) {
        self.persistanceController = persistanceController
    }
    
    func addRecipeToFavorites(recipe: Recipe) {
        persistanceController.addRecipeToFavorites(recipe: recipe)
    }
    
    func deleteFavorite(recipe: FavoriteRecipe) {
        persistanceController.deleteFavorite(recipe: recipe)
    }
    
    func getAllFavorites() -> [CDFavoriteRecipe] {
        persistanceController.getAllFavorites()
    }
}
