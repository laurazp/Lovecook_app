//
//  CategoriesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import Kingfisher

struct CategoriesView: View {
    @StateObject private var viewModel: CategoriesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(viewModel: CategoriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
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
    
    private func createRow(for category: Category) -> some View {
        CategoryItemView(category: category)
            /*.background(
                NavigationLink {
                    //TODO: MealsByCategoryView() ??
                    coordinator.makeMealsByCategoryView(for: category)
                    //CategoryDetailView(category: category)
                } label: { 
                    EmptyView()
                }
            )*/
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeCategoriesView().environmentObject(coordinator)}
