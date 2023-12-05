//
//  CategoriesRepository.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 21/11/23.
//

import Foundation

struct CategoriesRepository {
    private let remoteService: CategoriesRemoteService
    
    init(remoteService: CategoriesRemoteService) {
        self.remoteService = remoteService
    }
    
    func getCategories() async throws -> [Category] {
        do {
            return try await remoteService.getCategories()
        } catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
}
