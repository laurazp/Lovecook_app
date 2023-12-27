//
//  CategoryItemView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 22/11/23.
//

import SwiftUI

struct CategoryItemView: View {
    let category: Category
    
    var body: some View {
        ZStack {
            /* La imagen original proporcionada por la API se
             * mostraría utilizando la librería Kingfisher con:
             * KFImage(URL(string: category.categoryImage))
             * Pero en este caso he preferido mostrar otras imágenes
             * (desde Assets) que me han parecido un poco más vistosas.
             */

            Image(category.categoryTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black, radius: 5, x: 3, y: 5)
                .padding(12)
                .frame(width: 190, height: 200)
                .cornerRadius(16)
            
            
            VStack {
                Spacer()
                Text(category.categoryTitle)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .bold()
                .shadow(color: .black, radius: 5, x: 3, y: 5)
            }
                //TODO: tipografía ??
        }
        .frame(width: 190, height: 200)
    }
}

#Preview {
    CategoryItemView(category: .example)
}
