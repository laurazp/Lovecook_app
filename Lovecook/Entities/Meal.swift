//
//  Meal.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import Foundation

struct Meal: Decodable, Identifiable {
    var id: String {
        mealId
    }
    
    let mealId: String
    let mealTitle: String
    let mealImage: String
    
    enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case mealTitle = "strMeal"
        case mealImage = "strMealThumb"
    }
    
    static var example: Meal {
        Meal(
            mealId: "52874",
            mealTitle: "Beef and Mustard Pie",
            mealImage: "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg"
        )
    }
}
