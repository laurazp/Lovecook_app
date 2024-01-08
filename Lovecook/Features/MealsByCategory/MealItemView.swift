//
//  MealItemView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import SwiftUI
import Kingfisher

struct MealItemView: View {
    
    private struct Layout {
        static let placeholderImageName = "meal_placeholder"
    }
    
    let meal: Meal
    
    var body: some View {
        ZStack {
            CustomImageView(imageURL: meal.mealImage, placeholder: Layout.placeholderImageName)
                .aspectRatio(contentMode: .fill)
                .shadow(color: .black, radius: 7, x: 3, y: 5)
                .frame(width: .infinity, height: 170)
                .background(.black)
                .cornerRadius(16)
                .padding(.horizontal, 12)
            
                Text(meal.mealTitle)
                    .padding()
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .shadow(color: .black, radius: 5, x: 3, y: 5)
        }
    }
}

#Preview {
    MealItemView(meal: .example)
}
