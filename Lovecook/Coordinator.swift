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
    private let addRecipeToFavoritesUseCase: AddRecipeToFavoritesUseCase
    private let getFavoriteRecipesUseCase: GetFavoriteRecipesUseCase
    private let deleteFavoriteRecipeUseCase: DeleteFavoriteRecipeUseCase
    private let checkFavoriteAddedUseCase: CheckFavoriteAddedUseCase
    
    init() {
        let networkClient = URLSessionNetworkClient()
        let persistanceController = CoreDataPersistenceController()
        
        // MARK: - Categories
        let categoriesRemoteService = CategoriesRemoteService(networkClient: networkClient)
        self.categoriesRepository = CategoriesRepository(remoteService: categoriesRemoteService)
        self.getCategoriesUseCase = GetCategoriesUseCase(categoriesRepository: categoriesRepository)
        
        // MARK: - MealsByCategory
        let apiMealToMealMapper = ApiMealToMealMapper()
        let mealsByCategoryRemoteService = MealsByCategoryRemoteService(networkClient: networkClient, apiMealToMealMapper: apiMealToMealMapper)
        self.mealsByCategoryRepository = MealsByCategoryRepository(remoteService: mealsByCategoryRemoteService)
        self.getMealsByCategoryUseCase = GetMealsByCategoryUseCase(mealsByCategoryRepository: mealsByCategoryRepository)
        
        // MARK: - Recipes
        let apiRecipeToRecipeMapper = ApiRecipeToRecipeMapper()
        let recipesRemoteService = RecipesRemoteService(networkClient: networkClient, apiRecipeToRecipeMapper: apiRecipeToRecipeMapper)
        let recipesLocalService = RecipesLocalService(persistanceController: persistanceController)
        self.recipesRepository = RecipesRepository(remoteService: recipesRemoteService, localService: recipesLocalService)
        self.getRecipeUseCase = GetRecipeUseCase(recipesRepository: recipesRepository)
        self.addRecipeToFavoritesUseCase = AddRecipeToFavoritesUseCase(recipesRepository: recipesRepository)
        self.getFavoriteRecipesUseCase = GetFavoriteRecipesUseCase(recipesRepository: recipesRepository)
        self.deleteFavoriteRecipeUseCase  = DeleteFavoriteRecipeUseCase(recipesRepository: recipesRepository)
        self.checkFavoriteAddedUseCase = CheckFavoriteAddedUseCase(recipesRepository: recipesRepository)
    }
    
    // MARK: - CategoriesView
    func makeCategoriesView() -> CategoriesView {
        CategoriesView(viewModel: makeCategoriesViewModel())
    }
    
    // MARK: - MealsByCategoryView
    func makeMealsByCategoryView(for category: Category) -> MealsByCategoryView {
        MealsByCategoryView(category: category, viewModel: makeMealsByCategoryViewModel())
    }
    
    // MARK: - RecipesView
    func makeRecipesView(for meal: Meal) -> RecipesView {
        RecipesView(meal: meal, viewModel: makeRecipesViewModel())
    }
    
    // MARK: - UserAccountView
    func makeUserAccountView() -> UserAccountView {
        UserAccountView()
    }
    
    // MARK: - UserFavoritesView
    func makeUserFavoritesView() -> UserFavoritesView {
        UserFavoritesView(viewModel: makeUserFavoritesViewModel())
    }
    
    // MARK: - UserMainView
    func makeUserMainView() -> UserMainView {
        UserMainView()
    }
    
    // MARK: - PhotoGalleryView
    func makePhotoGalleryView() -> PhotoGalleryView {
        PhotoGalleryView(viewModel: makePhotoGalleryViewModel())
    }
    
    // MARK: Viewmodels
    private func makeCategoriesViewModel() -> CategoriesViewModel {
        return CategoriesViewModel(getCategoriesUseCase: getCategoriesUseCase)
    }
    
    private func makeMealsByCategoryViewModel() -> MealsByCategoryViewModel {
        return MealsByCategoryViewModel(getMealsByCategoryUseCase: getMealsByCategoryUseCase)
    }
    
    private func makeRecipesViewModel() -> RecipesViewModel {
        return RecipesViewModel(getRecipeUseCase: getRecipeUseCase, addRecipeToFavoritesUseCase: addRecipeToFavoritesUseCase, deleteFavoriteRecipeUseCase: deleteFavoriteRecipeUseCase, checkFavoriteAddedUseCase: checkFavoriteAddedUseCase)
    }
    private func makePhotoGalleryViewModel() -> PhotoGalleryViewModel {
        return PhotoGalleryViewModel()
    }
    private func makeUserFavoritesViewModel() -> UserFavoritesViewModel {
        return UserFavoritesViewModel(getFavoritesUseCase: getFavoriteRecipesUseCase,
                                      addRecipeToFavoritesUseCase: addRecipeToFavoritesUseCase, 
                                      deleteFavoriteRecipeUseCase: deleteFavoriteRecipeUseCase)
    }
}
