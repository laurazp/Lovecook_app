//
//  RecipesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 8/12/23.
//

import SwiftUI
import Kingfisher
import YouTubePlayerKit
import CoreData

struct RecipesView: View {
    var meal: Meal
    @StateObject private var viewModel: RecipesViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State var isFavorite: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    init(meal: Meal, viewModel: RecipesViewModel, isFavorite: Bool) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.meal = meal
        self.isFavorite = viewModel.checkIfFavorite(meal: self.meal)
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let recipe = viewModel.recipe {
                VStack(alignment: .leading, spacing: 10) {
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        KFImage(URL(string: recipe.recipeImage))
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                            .clipped()
                            .mask(RoundedCorners(tl: 0, tr: 0, bl: 15, br: 15))
                            .overlay(alignment: .topLeading) {
                                Text(recipe.recipeArea)
                                    .fontWeight(Font.Weight.medium)
                                    .font(Font.system(size: 16))
                                    .foregroundColor(Color.white)
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 8)
                                    .background(Color.black.opacity(0.5))
                                    .mask(RoundedCorners(tl: 0, tr: 0, bl: 0, br: 15))
                            }
                        
                        // MARK: - Favorite Button
                        Button {
                            isFavorite.toggle()
                            isFavorite ? viewModel.addRecipeToFavorites(recipe: recipe) : viewModel.deleteRecipeFromFavorites(recipe: recipe)
                            //TODO: añadir snackbar??
                            print(isFavorite ? "favorite added" : "favorite deleted")
                        } label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 23, height: 20)
                                .padding(12)
                        }
                        .background(.white)
                        .foregroundColor(viewModel.getFavIconForegroundColor(recipe: recipe, isFavorite: isFavorite))
                        .cornerRadius(.infinity)
                        .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        // MARK: - Category
                        HStack(alignment: .center, spacing: 0) {
                            Text("Category:  ")
                                .foregroundColor(Color.black)
                                .fontWeight(Font.Weight.bold)
                            Text(recipe.recipeCategory)
                                .foregroundColor(Color.gray)
                        }
                        .font(Font.custom("HelveticaNeue", size: 14))
                        .padding(.horizontal, 16)
                        
                        // MARK: - Tags
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
                            .padding(.horizontal, 16)
                            Spacer()
                        }
                        
                        Divider()
                            .padding([.leading, .trailing], -12)
                        Spacer()
                        
                        // MARK: - Ingredients
                        if let ingredients = viewModel.recipe?.ingredients {
                            VStack(alignment: .leading, spacing: 16) {
                                
                                Text("Ingredients")
                                    .font(.title2)
                                    .fontWeight(Font.Weight.heavy)
                                    .foregroundColor(Color.gray)
                                
                                ForEach(ingredients, id: \.self) { ingredient in
                                    HStack {
                                        Text("\(ingredient.measure)")
                                            .foregroundColor(Color.gray)
                                            .fontWeight(Font.Weight.heavy)
                                        Text("\(ingredient.ingredient)")
                                    }
                                    .font(Font.custom("HelveticaNeue", size: 18))
                                }
                            }
                            .padding([.horizontal, .bottom], 16)
                        }
                        
                        Divider()
                            .padding([.leading, .trailing], -12)
                        
                        // MARK: - Instructions
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Cooking Instructions")
                                .font(.title2)
                                .fontWeight(Font.Weight.heavy)
                                .foregroundColor(Color.gray)
                            
                            //TODO: gestionar error y loadingView
                            // MARK: - Video player
                            HStack(alignment: .center) {
                                YouTubePlayerView(YouTubePlayer(stringLiteral: recipe.recipeYoutubeUrl))
                            }
                            .padding(.bottom, 10)
                            .frame(height: 200)
                            
                            Text(recipe.recipeInstructions)
                                .font(Font.custom("HelveticaNeue", size: 18))
                                .foregroundColor(Color.black)
                        }
                        .padding(12)
                        
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
