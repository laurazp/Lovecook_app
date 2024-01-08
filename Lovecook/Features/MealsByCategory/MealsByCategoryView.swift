//
//  MealsByCategoryView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import SwiftUI

struct MealsByCategoryView: View {
    var category: Category
    @StateObject private var viewModel: MealsByCategoryViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(category: Category, viewModel: MealsByCategoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.category = category
    }
    
    var body: some View {
        
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.mealsByCategory, id: \.mealId) { meal in
                    createRow(for: meal)
                        .frame(maxWidth: .infinity)
                        .listRowSeparator(.hidden)
                }
                .navigationTitle(category.categoryTitle)
                .listStyle(PlainListStyle())
            }
        }
        .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
            Task {
                await viewModel.getMealsByCategory(category: category)
            }
        })
        .task {
            await viewModel.getMealsByCategory(category: category)
        }
    }
    
    private func createRow(for meal: Meal) -> some View {
        MealItemView(meal: meal)
            .background(
                NavigationLink {
                    coordinator.makeRecipesView(for: meal)
                } label: { EmptyView() }
                    .buttonStyle(PlainButtonStyle())
            )
            .buttonStyle(PlainButtonStyle())
            .shadow(color: .gray, radius: 5, x: 3, y: 3)
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeMealsByCategoryView(for: .example).environmentObject(coordinator)
}
