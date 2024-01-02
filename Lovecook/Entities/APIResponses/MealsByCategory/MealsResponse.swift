//
//  MealsResponse.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 7/12/23.
//

import Foundation

struct MealsResponse: Decodable {
    let meals: [ApiMeal]
}
