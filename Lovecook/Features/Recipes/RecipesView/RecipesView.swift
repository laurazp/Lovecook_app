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
                    KFImage(URL(string: meal.mealImage))
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
                        Text(meal.mealTitle)
                            .fontWeight(Font.Weight.heavy)
                            .font(Font.custom("HelveticaNeue-Bold", size: 22))
                        
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
                                Text(recipe.recipeCategory)
                            }.font(Font.custom("HelveticaNeue", size: 14))
                            
                        }
                        .padding([.top, .bottom], 8)
                        
                        Text(recipe.recipeInstructions)
                            .font(Font.custom("HelveticaNeue-Bold", size: 16))
                            .foregroundColor(Color.gray)
                        
                        Spacer()
                        
                        //TODO: gestionar error y loadingView
                        HStack(alignment: .center) {
                            YouTubePlayerView(YouTubePlayer(stringLiteral: recipe.recipeYoutubeUrl))
                        }
                        .padding(8)
                        .frame(width: 350, height: 200)
                        
                        Spacer()
                        
                        Divider()
                        //.color: Color.gray.opacity(0.3)
                            .padding([.leading, .trailing], -12)
                        
                        // TODO: modificar y añadir resto de ingredientes
                        HStack(alignment: .center, spacing: 4) {
                            Text(String.init(format: "$%.2f", arguments: ["15€"]))
                                .fontWeight(Font.Weight.heavy)
                            Text("for 2 people")
                                .font(Font.system(size: 13))
                                .fontWeight(Font.Weight.bold)
                                .foregroundColor(Color.gray)
                            Spacer()
                            /*Image("Plus-Icon")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 15, height: 15, alignment: .center)
                             .colorMultiply(Color(red: 231/255, green: 119/255, blue: 112/255))
                             .onTapGesture {}*/
                            Text("BUY NOW")
                                .fontWeight(Font.Weight.heavy)
                                .foregroundColor(Color(red: 231/255, green: 119/255, blue: 112/255))
                            //.onTapGesture {}
                            
                        }.padding([.top, .bottom], 8)
                        
                        
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
