//
//  RecipeResponse.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 7/12/23.
//

import Foundation

struct RecipeResponse: Decodable {
    let meals: [ApiRecipe]
}
