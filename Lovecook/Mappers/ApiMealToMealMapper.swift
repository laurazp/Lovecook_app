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
            mealImage: apiMeal.mealImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRueIWRNPWkGM4KhjYE2J3CdU9SgFmZETapiw&usqp=CAU")
    }
}
