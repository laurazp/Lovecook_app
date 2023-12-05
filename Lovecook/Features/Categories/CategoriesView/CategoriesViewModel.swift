//
//  CategoriesViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    
    private let getCategoriesUseCase: GetCategoriesUseCase
    @Published var categories = [Category]()
    //@Published var showErrorMessage = false
    @Published var isLoading = false
    @Published var error: Error?
    
    init(getCategoriesUseCase: GetCategoriesUseCase) {
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    @MainActor
    func getCategories() async {
        error = nil
        isLoading = true
        
        do {
            categories = try await getCategoriesUseCase.execute()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
