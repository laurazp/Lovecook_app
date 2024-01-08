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
import Toast

struct RecipesView: View {
    
    private struct Layout {
        static let favoriteButtonImageName = "heart"
        static let favoriteButtonClickedImageName = "heart.fill"
        static let favoriteAddedToastText = "Favorite added"
        static let favoriteDeletedToastText = "Favorite deleted"
        static let categoryTitle = "Category:  "
        static let tagsTitle = "Tags:"
        static let ingredientsTitle = "Ingredients"
        static let cookingInstructionsTitle = "Cooking Instructions"
        static let videoPlayerHeight: CGFloat = 200
        static let textFontName: String = "HelveticaNeue"
        static let tagsFontName: String = "HelveticaNeue-Medium"
    }
    
    var meal: Meal
    @StateObject private var viewModel: RecipesViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var isFavorite: Bool
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    init(meal: Meal, viewModel: RecipesViewModel, isFavorite: Bool) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.meal = meal
        self._isFavorite = State(initialValue: viewModel.checkIfFavorite(meal: meal))
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
                            
                            isFavorite ? Toast.default(
                                image: UIImage(systemName: Layout.favoriteButtonClickedImageName)!,
                                title: Layout.favoriteAddedToastText).show() : Toast.default(
                                    image: UIImage(systemName: Layout.favoriteButtonImageName)!,
                                    title: Layout.favoriteDeletedToastText).show()
                        } label: {
                            Image(systemName: Layout.favoriteButtonClickedImageName)
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
                            Text(Layout.categoryTitle)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .fontWeight(Font.Weight.bold)
                            Text(recipe.recipeCategory)
                                .foregroundColor(Color.gray)
                        }
                        .font(Font.custom(Layout.textFontName, size: 14))
                        .padding(.horizontal, 16)
                        
                        // MARK: - Tags
                        if let recipeTags = viewModel.recipe?.recipeTags {
                            HStack {
                                Text(Layout.tagsTitle)
                                    .font(Font.system(size: 13))
                                    .fontWeight(Font.Weight.heavy)
                                
                                ForEach(recipeTags, id: \.self) { tag in
                                    HStack {
                                        Text(tag)
                                            .font(Font.custom(Layout.tagsFontName, size: 12))
                                            .padding([.leading, .trailing], 10)
                                            .padding([.top, .bottom], 5)
                                            .foregroundColor(Color.white)
                                    }
                                }
                                .background(Color.teal)
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
                                
                                Text(Layout.ingredientsTitle)
                                    .font(.title2)
                                    .fontWeight(Font.Weight.heavy)
                                    .foregroundColor(Color.gray)
                                
                                ForEach(ingredients, id: \.self) { ingredient in
                                    HStack {
                                        Text("\(ingredient.measure)")
                                            .foregroundColor(Color.gray)
                                            .fontWeight(Font.Weight.heavy)
                                        Text("\(ingredient.ingredient)")
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                    .font(Font.custom(Layout.textFontName, size: 18))
                                }
                            }
                            .padding([.horizontal, .bottom], 16)
                        }
                        
                        Divider()
                            .padding([.leading, .trailing], -12)
                        
                        // MARK: - Instructions
                        VStack(alignment: .leading, spacing: 18) {
                            Text(Layout.cookingInstructionsTitle)
                                .font(.title2)
                                .fontWeight(Font.Weight.heavy)
                                .foregroundColor(Color.gray)
                            
                            // MARK: - Video player
                            HStack(alignment: .center) {
                                YouTubePlayerView(YouTubePlayer(stringLiteral: recipe.recipeYoutubeUrl))
                            }
                            .padding(.bottom, 10)
                            .frame(height: Layout.videoPlayerHeight)
                            
                            Text(recipe.recipeInstructions)
                                .font(Font.custom(Layout.textFontName, size: 18))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .padding(12)
                        
                        Spacer()
                    }
                    .padding(12)
                    .navigationTitle(meal.mealTitle)
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(15)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                .padding(20)
            }
        }
        .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
            Task {
                await viewModel.getRecipe(mealId: Int(meal.mealId) ?? 1)
            }
        })
        .task {
            await viewModel.getRecipe(mealId: Int(meal.mealId) ?? 1)
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeRecipesView(for: .example).environmentObject(coordinator)
}
