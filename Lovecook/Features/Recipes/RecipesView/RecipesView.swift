//
//  RecipesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 8/12/23.
//

import SwiftUI
import Kingfisher
import YouTubePlayerKit

struct RecipesView: View {
    var meal: Meal
    @StateObject private var viewModel: RecipesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(meal: Meal, viewModel: RecipesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.meal = meal
    }
    
    var body: some View {
        
        //let recipe = viewModel.getRecipe(mealId: Int(meal.mealId)
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let recipe = viewModel.recipe {
                VStack(alignment: .leading, spacing: 10) {
                    KFImage(URL(string: recipe.recipeImage))
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                        .clipped()
                        .overlay(
                            Text(recipe.recipeArea)
                                .fontWeight(Font.Weight.medium)
                                .font(Font.system(size: 16))
                                .foregroundColor(Color.white)
                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 8)
                                .background(Color.black.opacity(0.5))
                                .mask(RoundedCorners(tl: 0, tr: 0, bl: 0, br: 15))
                            , alignment: .topLeading)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Spacer()
                        
                        // Tags and Category Stack
                        VStack(alignment: .leading, spacing: 4) {
                            
                            if let recipeTags = viewModel.recipe?.recipeTags {
                                HStack {
                                    Text("Tags:")
                                        .font(Font.system(size: 13))
                                        .fontWeight(Font.Weight.heavy)
                                    
                                    ForEach(recipeTags, id: \.self) { tag in
                                        HStack {
                                            Text(tag)
                                                .font(Font.custom("HelveticaNeue-Medium", size: 12))
                                                .padding([.leading, .trailing], 10)
                                                .padding([.top, .bottom], 5)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .background(Color(red: 43/255, green: 175/255, blue: 187/255))
                                    .cornerRadius(7)
                                }
                                Spacer()
                            }
                            
                            HStack(alignment: .center, spacing: 0) {
                                Text("Category: ")
                                    .foregroundColor(Color.gray)
                                    .fontWeight(Font.Weight.bold)
                                Text(recipe.recipeCategory)
                            }.font(Font.custom("HelveticaNeue", size: 14))
                            Spacer()
                        }
                        .padding([.top, .bottom], 8)
                        
                        Divider()
                            .padding([.leading, .trailing], -12)
                        
                        // TODO: añadir ingredientes
                        HStack(alignment: .center, spacing: 6) {
                            Spacer()
                            Text("measure")
                                .fontWeight(Font.Weight.bold)
                                .foregroundColor(Color.gray)
                            Text("ingredient")
                                .fontWeight(Font.Weight.heavy)
                            Spacer()
                        }.padding([.top, .bottom], 8)
                        
                        Divider()
                            .padding([.leading, .trailing], -12)
                        
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("PREPARATION")
                                .fontWeight(Font.Weight.heavy)
                                .font(Font.system(size: 18))
                                .foregroundColor(Color.gray)

                            Spacer()
                            
                            Spacer()
                            Text(recipe.recipeInstructions)
                                .font(Font.custom("HelveticaNeue-Bold", size: 16))
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .padding(12)
                        
                        //TODO: gestionar error y loadingView
                        HStack(alignment: .center) {
                            YouTubePlayerView(YouTubePlayer(stringLiteral: recipe.recipeYoutubeUrl))
                        }
                        .padding(8)
                        .frame(width: 350, height: 200)
                        
                        Spacer()
                    }
                    .padding(12)
                    .navigationTitle(meal.mealTitle)
                    
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                .padding(20)
            }
        }.task {
            await viewModel.getRecipe(mealId: Int(meal.mealId) ?? 1)
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getRecipe(mealId: Int(meal.mealId) ?? 1)
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeRecipesView(for: .example).environmentObject(coordinator)
}
