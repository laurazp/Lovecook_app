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
                    .navigationTitle("Categories")
                    .padding(12)
                }
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
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeCategoriesView().environmentObject(coordinator)
}
