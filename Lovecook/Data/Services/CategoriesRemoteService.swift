//
//  CategoriesRemoteService.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

struct CategoriesRemoteService {
    
    let networkClient: URLSessionNetworkClient
    
    init(networkClient: URLSessionNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCategories() async throws -> [Category] {
        let response: APIResponse<Category> = try await networkClient.get(url: "https://www.themealdb.com/api/json/v1/1/categories.php")
        return response.results!
    }
}
