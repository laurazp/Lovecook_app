//
//  CategoriesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI

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
                List(viewModel.categories, id: \.idCategory) { category in
                    NavigationLink {
                        coordinator.makeMealsByCategoryView(for: category)
                    } label: {
                        createRow(for: category)
                    }.frame(
                        maxWidth: .infinity,
                        alignment: .topLeading
                    )
                }
            }
        }.task {
            await viewModel.getCategories()
        }.navigationTitle("Categories")
        .alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getCategories()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }
        
        
        /*NavigationStack {
         List(viewModel.categories) {
         category in
         //makeGoToDetailNavigationLink(for: category)
         
         createRow(for: category)
         
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
         await viewModel.getCategories()
         }
         .navigationTitle("Categories")
         .alert(isPresented: $viewModel.showErrorMessage, content: {
         Alert(
         title: Text("Error"),
         message: Text("There was an error loading the list. Please, try again later."),
         dismissButton: .cancel()
         )
         })
         }*/
        
        /*List(recipes) { recipe in
         Section {
         createRow(for: recipe)
         }
         .listRowSeparator(.hidden)
         }*/
    }
    
    private func createRow(for category: Category) -> some View {
        CategoryItemView(category: category)
            .background(
                NavigationLink(destination: {
                    //TODO: MealsByCategoryView() ??
                    coordinator.makeMealsByCategoryView(for: category)
                    //CategoryDetailView(category: category)
                }, label: { EmptyView() })
            )
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
