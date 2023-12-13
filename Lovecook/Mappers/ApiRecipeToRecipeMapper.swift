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
            recipeTitle: apiRecipe.recipeTitle,
            recipeCategory: apiRecipe.recipeCategory,
            recipeArea: apiRecipe.recipeArea ?? "N/A",
            recipeInstructions: apiRecipe.recipeInstructions,
            recipeImage: apiRecipe.recipeImage,
            recipeTags: mapRecipeTags(tags: apiRecipe.recipeTags),
            recipeYoutubeUrl: apiRecipe.recipeYoutubeUrl ?? "")
    }
    
    private func mapRecipeTags(tags: String?) -> String {
        var mappedTags = ""
        var mappedArray = [String]()
        
        if tags != nil {
            let tagsArray = tags!.components(separatedBy: ",")
            for tag in tagsArray {
                mappedArray.append("#\(tag) ")
            }
            mappedTags = mappedArray.joined()
        }
        return mappedTags
    }
}
