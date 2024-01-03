//
//  ApiRecipeToRecipeMapper.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 12/12/23.
//

import Foundation

class ApiRecipeToRecipeMapper {
    
    func mapToRecipe(apiRecipe: ApiRecipe) -> Recipe {
        return Recipe(
            recipeId: apiRecipe.recipeId,
            recipeTitle: apiRecipe.recipeTitle ?? "Unknown",
            recipeCategory: apiRecipe.recipeCategory,
            recipeArea: apiRecipe.recipeArea ?? "Unknown",
            recipeInstructions: apiRecipe.recipeInstructions ?? "Instructions coming soon...",
            recipeImage: apiRecipe.recipeImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDE-6QWisvXUHctHi2_h1Hnxx925BJO6046Q&usqp=CAU",
            recipeTags: mapRecipeTags(tags: apiRecipe.recipeTags, category: apiRecipe.recipeCategory),
            recipeYoutubeUrl: apiRecipe.recipeYoutubeUrl ?? "",
            ingredients: mapIngredientsAndMeasures(apiRecipe: apiRecipe)
        )
    }
    
    private func mapRecipeTags(tags: String?, category: String) -> [String] {
        var mappedArray = [String]()
        
        if tags != nil {
            let tagsArray = tags!.components(separatedBy: ",")
            for tag in tagsArray {
                mappedArray.append("#\(tag) ")
            }
        } else {
            mappedArray.append("#\(category) ")
        }
        return mappedArray
    }
    
    private func mapIngredientsAndMeasures(apiRecipe: ApiRecipe) -> [Ingredient] {
        let ingredients = [apiRecipe.ingredient1, apiRecipe.ingredient2, apiRecipe.ingredient3, apiRecipe.ingredient4, apiRecipe.ingredient5, apiRecipe.ingredient6, apiRecipe.ingredient7, apiRecipe.ingredient8, apiRecipe.ingredient9, apiRecipe.ingredient10, apiRecipe.ingredient11, apiRecipe.ingredient12, apiRecipe.ingredient13, apiRecipe.ingredient14, apiRecipe.ingredient15, apiRecipe.ingredient16, apiRecipe.ingredient17, apiRecipe.ingredient18, apiRecipe.ingredient19, apiRecipe.ingredient20]
        
        let measures = [apiRecipe.measure1, apiRecipe.measure2, apiRecipe.measure3, apiRecipe.measure4, apiRecipe.measure5, apiRecipe.measure6, apiRecipe.measure7, apiRecipe.measure8, apiRecipe.measure9, apiRecipe.measure10, apiRecipe.measure11, apiRecipe.measure12, apiRecipe.measure13, apiRecipe.measure14, apiRecipe.measure15, apiRecipe.measure16, apiRecipe.measure17, apiRecipe.measure18, apiRecipe.measure19, apiRecipe.measure20]

        var ingredientList: [Ingredient] = []

        for (index, ingredient) in ingredients.enumerated() {
            if let ingredient = ingredient, !ingredient.isEmpty {
                let measure = measures[index] ?? ""
                ingredientList.append(Ingredient(ingredient: ingredient, measure: measure))
            }
        }

        return ingredientList
    }
}
