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
                    NavigationLink {
                        coordinator.makeRecipesView(for: meal)
                    } label: {
                        MealItemView(meal: meal)
                    }
                }.navigationTitle(category.categoryTitle)
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getMealsByCategory(category: category)
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            await viewModel.getMealsByCategory(category: category)
        }
    }
}

/*NavigationStack {
 List(viewModel.mealsByCategory) {
 meal in
 //makeGoToDetailNavigationLink(for: category)
 
 createRow(for: meal)
 
 //.listRowSeparator(.hidden)
 
 
 //                NavigationLink {
 //                    //TODO: MealsByCategoryView()
 //                    CategoryDetailView(category: category)
 //                } label: {
 //                    CategoryItemView(category: category)
 //                }
 }
 .task {
 // TODO: añadir loader
 await viewModel.getMealsByCategory(category: category)
 }
 //TODO: mostrar nombre de la categoría
 .navigationTitle(category.strCategory)
 .alert(isPresented: $viewModel.showErrorMessage, content: {
 Alert(
 title: Text("Error"),
 message: Text("There was an error loading the list. Please, try again later."),
 dismissButton: .cancel()
 )
 })
 }*/


/*
 NavigationStack {
 if viewModel.isLoading {
 ProgressView()
 } else {
 List(viewModel.categories, id: \.categoryId) { category in
 NavigationLink {
 coordinator.makeMealsByCategoryView(for: category)
 } label: {
 CategoryItemView(category: category)
 //createRow(for: category)
 }
 }
 /*.refreshable {
  Task {
  await viewModel.getCategories()
  }
  }*/
 }
 }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
 Button("OK") {}
 Button("Retry") {
 Task {
 await viewModel.getCategories()
 }
 }
 } message: {
 Text(viewModel.error?.localizedDescription ?? "")
 }.task {
 await viewModel.getCategories()
 }
 }
 */

/*private func createRow(for meal: Meal) -> some View {
    MealItemView(meal: meal)
        .background(
            NavigationLink(destination: {
                //TODO: RecipeView()
                RecipeDetailView(meal: meal)
            }, label: { EmptyView() })
        )
}*/


//}

//    func makeGoToDetailNavigationLink(for category: Category) -> some View {
//        NavigationLink {
//            coordinator.makeCategoryDetailView(category: category)
//        } label: {
//            CategoryRowView(category: category)
//        }
//    }
//}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeMealsByCategoryView(for: .example).environmentObject(coordinator)
}
