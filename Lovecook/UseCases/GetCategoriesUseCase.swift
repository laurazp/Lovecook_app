//
//  GetCategoriesUseCase.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

struct GetCategoriesUseCase {
    let categoriesRepository: CategoriesRepository
    
    init(categoriesRepository: CategoriesRepository) {
        self.categoriesRepository = categoriesRepository
    }
    
    func execute() async throws -> [Category] {
        try await categoriesRepository.getCategories()
    }
}
