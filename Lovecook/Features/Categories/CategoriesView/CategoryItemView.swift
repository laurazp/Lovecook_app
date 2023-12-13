//
//  CategoryItemView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import SwiftUI
import Kingfisher

struct CategoryItemView: View {
    let category: Category
    
    var body: some View {
        ZStack {
            KFImage(URL(string: category.categoryImage))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black, radius: 5, x: 3, y: 5)
                .padding(12)
                .frame(width: 180, height: 200)
                .background(.brown)
                .cornerRadius(16)
            Text(category.categoryTitle)
                .font(.largeTitle)
                .foregroundStyle(.white)
                .bold()
                .shadow(color: .black, radius: 5, x: 3, y: 5)
                //TODO: tipografía ??
        }
        .frame(width: 190, height: 200)
    }
}

#Preview {
    CategoryItemView(category: .example)
}
