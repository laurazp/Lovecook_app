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
    
    //TODO: borrar parámetros que no vaya a usar
    
    /*let strIngredient1: String?
     let strIngredient2: String?
     let strIngredient3: String?
     let strIngredient4: String?
     let strIngredient5: String?
     let strIngredient6: String?
     let strIngredient7: String?
     let strIngredient8: String?
     let strIngredient9: String?
     let strIngredient10: String?
     let strIngredient11: String?
     let strIngredient12: String?
     let strIngredient13: String?
     let strIngredient14: String?
     let strIngredient15: String?
     let strIngredient16: String?
     let strIngredient17: String?
     let strIngredient18: String?
     let strIngredient19: String?
     let strIngredient20: String?
     let strMeasure1: String?
     let strMeasure2: String?
     let strMeasure3: String?
     let strMeasure4: String?
     let strMeasure5: String?
     let strMeasure6: String?
     let strMeasure7: String?
     let strMeasure8: String?
     let strMeasure9: String?
     let strMeasure10: String?
     let strMeasure11: String?
     let strMeasure12: String?
     let strMeasure13: String?
     let strMeasure14: String?
     let strMeasure15: String?
     let strMeasure16: String?
     let strMeasure17: String?
     let strMeasure18: String?
     let strMeasure19: String?
     let strMeasure20: String?*/
    
    static var example: Recipe {
        Recipe(
            recipeId: "5346",
            recipeTitle: "Beef and Oyster pie",
            recipeCategory: "Beef",
            recipeArea: "UK",
            recipeInstructions: "Istructions here blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla",
            recipeImage: "https://www.themealdb.com/images/media/meals/wrssvt1511556563.jpg",
            recipeTags: ["Drink", "Fit", "Cool"],
            recipeYoutubeUrl: "Youtube url here")
    }
}
