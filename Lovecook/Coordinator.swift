//
//  Coordinator.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

class Coordinator: ObservableObject {
    private let categoriesRepository: CategoriesRepository
    private let mealsByCategoryRepository: MealsByCategoryRepository
    private let recipesRepository: RecipesRepository
    
    private let getCategoriesUseCase: GetCategoriesUseCase
    private let getMealsByCategoryUseCase: GetMealsByCategoryUseCase
    private let getRecipeUseCase: GetRecipeUseCase
    
    init() {
        let networkClient = URLSessionNetworkClient()
        
        // MARK: - Categories
        let categoriesRemoteService = CategoriesRemoteService(networkClient: networkClient)
        self.categoriesRepository = CategoriesRepository(remoteService: categoriesRemoteService)
        self.getCategoriesUseCase = GetCategoriesUseCase(categoriesRepository: categoriesRepository)
        
        // MARK: - MealsByCategory
        let mealsByCategoryRemoteService = MealsByCategoryRemoteService(networkClient: networkClient)
        self.mealsByCategoryRepository = MealsByCategoryRepository(remoteService: mealsByCategoryRemoteService)
        self.getMealsByCategoryUseCase = GetMealsByCategoryUseCase(mealsByCategoryRepository: mealsByCategoryRepository)
        
        // MARK: - Recipes
        let recipesRemoteService = RecipesRemoteService(networkClient: networkClient)
        self.recipesRepository = RecipesRepository(remoteService: recipesRemoteService)
        self.getRecipeUseCase = GetRecipeUseCase(recipesRepository: recipesRepository)
    }
    
    // MARK: - CategoriesView
    func makeCategoriesView() -> CategoriesView {
        CategoriesView(viewModel: makeCategoriesViewModel())
    }
    
    // MARK: - MealsByCategoryView
    func makeMealsByCategoryView(for category: Category) -> MealsByCategoryView {
        MealsByCategoryView(category: category, viewModel: makeMealsByCategoryViewModel())
    }
    
    // MARK: Viewmodels
    private func makeCategoriesViewModel() -> CategoriesViewModel {
        return CategoriesViewModel(getCategoriesUseCase: getCategoriesUseCase)
    }
    
    private func makeMealsByCategoryViewModel() -> MealsByCategoryViewModel {
        return MealsByCategoryViewModel(getMealsByCategoryUseCase: getMealsByCategoryUseCase)
    }
    
    /*private func makeRecipesViewModel() -> RecipesViewModel {
        return RecipesViewModel(getRecipeUseCase: getRecipeUseCase)
    }*/
}
