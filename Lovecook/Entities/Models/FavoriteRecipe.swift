//
//  FavoriteRecipe.swift
//  Lovecook
//
//  Created by Laura Zafra on 1/1/24.
//

import Foundation

struct FavoriteRecipe: Hashable {
    let title: String?
    let id: String
    let image: String
    
    static var example: FavoriteRecipe {
        FavoriteRecipe(
            title: "Apple pie", 
            id: "1234",
            image: "")
    }
}

