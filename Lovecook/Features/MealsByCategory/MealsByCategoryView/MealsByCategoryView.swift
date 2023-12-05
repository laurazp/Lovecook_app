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
    //@State var gridLayout: [GridItem] = [ GridItem() ]
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(category: Category, viewModel: MealsByCategoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.category = category
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 20) {
                        ForEach(viewModel.mealsByCategory) { meal in
                            Image(meal.strMealThumb)
                                .font(.system(size: 30))
                                .frame(width: 50, height: 50)
                                .background(.black)
                                .cornerRadius(10)
                        }
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
    }
    
    private func createRow(for meal: Meal) -> some View {
        MealItemView(meal: meal)
            .background(
                NavigationLink(destination: {
                    //TODO: RecipeView()
                    RecipeDetailView(meal: meal)
                }, label: { EmptyView() })
            )
    }
}

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
    return coordinator.makeCategoriesView().environmentObject(coordinator)}
