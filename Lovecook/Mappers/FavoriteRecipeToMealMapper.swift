//
//  FavoriteRecipeToMealMapper.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 1/1/24.
//

import Foundation

class FavoriteRecipeToMealMapper {
    
    func mapFavoriteToMeal(favorite: FavoriteRecipe) -> Meal {
        return Meal(
            mealId: favorite.id,
            mealTitle: favorite.title ?? "Unknown",
            mealImage: favorite.image)
    }
}
