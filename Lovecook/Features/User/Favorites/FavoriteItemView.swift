//
//  FavoriteItemView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 2/1/24.
//

import SwiftUI
import Kingfisher

struct FavoriteItemView: View {
    
    private struct Layout {
        static let placeholderImageName = "meal_placeholder"
        static let favoriteDefaultTitle = "Unknown"
    }
    
    let favoriteItem: FavoriteRecipe
    
    var body: some View {
        ZStack {
            CustomImageView(imageURL: favoriteItem.image, placeholder: Layout.placeholderImageName)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black, radius: 7, x: 3, y: 5)
                .frame(width: .infinity, height: 80)
                .background(.black)
                .cornerRadius(16)
            
            Text(favoriteItem.title ?? Layout.favoriteDefaultTitle)
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .shadow(color: .black, radius: 5, x: 3, y: 5)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
}

#Preview {
    FavoriteItemView(favoriteItem: .example)
}
