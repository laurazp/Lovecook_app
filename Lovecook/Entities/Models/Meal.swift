//
//  Meal.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import Foundation

struct Meal {
    var id: String {
        mealId
    }
    let mealId: String
    let mealTitle: String
    let mealImage: String
    
    static var example: Meal {
        Meal(
            mealId: "52874",
            mealTitle: "Beef and Mustard Pie",
            mealImage: "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg"
        )
    }
}
