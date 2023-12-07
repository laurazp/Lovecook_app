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
        VStack(spacing: 16) {
            KFImage(URL(string: category.categoryImage))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black, radius: 5, x: 3, y: 5)
            HStack {
                Text(category.categoryTitle)
                    .padding(.top, 8)
                    .font(.title)
                    //TODO: tipografía ??
                    //.foregroundStyle(.black)
                Spacer()
            }.frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
        }
    }
}

#Preview {
    CategoryItemView(category: .example)
}
