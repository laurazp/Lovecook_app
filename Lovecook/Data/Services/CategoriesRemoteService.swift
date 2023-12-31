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
        let response: CategoriesResponse = try await networkClient.getCall(url: NetworkConstants.categoriesNetworkUrl, queryParams: nil)
        return response.categories
    }
}
