//
//  Recipe.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 12/12/23.
//

import Foundation

struct Recipe {
    var id: String {
        recipeId
    }
    let recipeId: String
    let recipeTitle: String
    let recipeCategory: String
    let recipeArea: String
    let recipeInstructions: String
    let recipeImage: String
    let recipeTags: [String]
    let recipeYoutubeUrl: String
    var ingredients: [Ingredient]

    static var example: Recipe {
        Recipe(
            recipeId: "5346",
            recipeTitle: "Beef and Oyster pie",
            recipeCategory: "Beef",
            recipeArea: "UK",
            recipeInstructions: "Istructions here blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla",
            recipeImage: "https://www.themealdb.com/images/media/meals/wrssvt1511556563.jpg",
            recipeTags: ["Drink", "Fit", "Cool"],
            recipeYoutubeUrl: "Youtube url here",
            ingredients: [Ingredient(ingredient: "Oysters", measure: "1kg"), Ingredient(ingredient: "Butter", measure: "2tbs"), Ingredient(ingredient: "Chicken soup", measure: "1L")]
        )
    }
}
