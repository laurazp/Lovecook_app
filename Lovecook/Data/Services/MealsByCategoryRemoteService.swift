//
//  MealsByCategoryRemoteService.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct MealsByCategoryRemoteService {
    
    let networkClient: URLSessionNetworkClient
    
    init(networkClient: URLSessionNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getMealsByCategory(category: Category) async throws -> [Meal] {
        let queryParams = ["c": "\(category)"]
        
        let response: MealsResponse = try await networkClient.getCall(url: NetworkConstants.mealsByCategoryNetworkUrl, queryParams: queryParams)
        return response.meals
    }
}
