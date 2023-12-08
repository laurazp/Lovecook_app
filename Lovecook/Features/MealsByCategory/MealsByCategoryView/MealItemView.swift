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
        ZStack {
            KFImage(URL(string: meal.mealImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black, radius: 7, x: 3, y: 5)
                //.padding(12)
                .frame(width: 320, height: 170)
                .background(.black)
                .cornerRadius(16)
            
                Text(meal.mealTitle)
                    .padding(.leading, 18)
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
