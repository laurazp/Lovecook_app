//
//  ApiMealToMealMapper.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import Foundation
import SwiftUI

class ApiMealToMealMapper {
    
    func mapToMeal(apiMeal: ApiMeal) -> Meal {
        return Meal(
            mealId: apiMeal.mealId,
            mealTitle: apiMeal.mealTitle ?? "Unknown",
            mealImage: apiMeal.mealImage ?? "")
    }
}
