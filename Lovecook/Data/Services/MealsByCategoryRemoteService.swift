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
        let response: APIResponse<Meal> = try await networkClient.get(url: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)")
        return response.results!
    }
}
