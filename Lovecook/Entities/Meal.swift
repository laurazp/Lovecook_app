//
//  Meal.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import Foundation

struct Meal: Decodable, Identifiable {
    var id: String {
        idMeal
    }
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    static var example: Meal {
        Meal(
            idMeal: "52874",
            strMeal: "Beef and Mustard Pie",
            strMealThumb: "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg"
        )
    }
}
