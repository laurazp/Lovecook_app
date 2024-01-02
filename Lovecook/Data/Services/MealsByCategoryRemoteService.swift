//
//  MealsByCategoryRemoteService.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import Foundation

struct MealsByCategoryRemoteService {
    
    let networkClient: URLSessionNetworkClient
    let apiMealToMealMapper: ApiMealToMealMapper
    
    init(networkClient: URLSessionNetworkClient, apiMealToMealMapper: ApiMealToMealMapper) {
        self.networkClient = networkClient
        self.apiMealToMealMapper = apiMealToMealMapper
    }
    
    func getMealsByCategory(category: Category) async throws -> [Meal] {
        var mappedMealList = [Meal]()
        let queryParams = ["c": "\(category.categoryTitle)"]
        
        let response: MealsResponse = try await networkClient.getCall(url: NetworkConstants.mealsByCategoryNetworkUrl, queryParams: queryParams)
        
        for meal in response.meals {
            let mappedMeal = apiMealToMealMapper.mapToMeal(apiMeal: meal)
            mappedMealList.append(mappedMeal)
        }
        return mappedMealList
    }
}
