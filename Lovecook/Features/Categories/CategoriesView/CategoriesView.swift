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
                        createRow(for: category)
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
        
        /*NavigationStack {
            List(viewModel.categories) { category in
                NavigationLink {
                    coordinator.makeMealsByCategoryView(for: category)
                } label: {
                    createRow(for: category)
                }
            }.task {
                // TODO: añadir loader
                await viewModel.getCategories()
            }
            .navigationTitle("Categories")
            .alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
                Button("OK") {}
                Button("Retry") {
                    Task {
                        await viewModel.getCategories()
                    }
                }
            }
        }
    }*/
    
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
    
    //    func makeGoToDetailNavigationLink(for category: Category) -> some View {
    //        NavigationLink {
    //            coordinator.makeCategoryDetailView(category: category)
    //        } label: {
    //            CategoryRowView(category: category)
    //        }
    //    }
    //}
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeCategoriesView().environmentObject(coordinator)}
