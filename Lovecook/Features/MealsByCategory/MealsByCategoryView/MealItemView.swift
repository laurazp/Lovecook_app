//
//  MealItemView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 23/11/23.
//

import SwiftUI
import Kingfisher

struct MealItemView: View {
    let meal: Meal
    
    var body: some View {
        VStack(spacing: 16) {
            KFImage(URL(string: meal.mealImage))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black, radius: 5, x: 3, y: 5)
            HStack {
                Text(meal.mealTitle)
                    .padding(.top, 8)
                    .font(.title)
                    //TODO: tipografía ??
                    //.foregroundStyle(.black)
                Spacer()
            }
        }
    }
}

#Preview {
    MealItemView(meal: .example)
}
