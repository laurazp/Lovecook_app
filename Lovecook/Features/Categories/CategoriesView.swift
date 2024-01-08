//
//  CategoriesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import Kingfisher

struct CategoriesView: View {
    
    private struct Layout {
        static let categoriesTitle = "Categories"
    }
    
    @StateObject private var viewModel: CategoriesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(viewModel: CategoriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 14) {
                        ForEach(viewModel.categories, id: \.categoryId) { category in
                            NavigationLink {
                                coordinator.makeMealsByCategoryView(for: category)
                            } label: {
                                CategoryItemView(category: category)
                            }
                        }
                    }
                    .navigationTitle(Layout.categoriesTitle)
                    .padding(12)
                }
            }
        }
        .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
            Task {
                await viewModel.getCategories()
            }
        })
        .task {
            await viewModel.getCategories()
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeCategoriesView().environmentObject(coordinator)
}
