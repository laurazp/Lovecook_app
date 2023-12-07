//
//  CategoryDetailView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    
    var body: some View {
        //TODO: MealsByCategoryView()
        Text(category.categoryTitle)
            .navigationTitle(category.categoryTitle)
//            .toolbar {
//                ToolbarItem {
//                    Button(action: {
//                        print("Borrar")
//                    }, label: {
//                        Image(systemName: "trash")
//                    })
//                    .tint(.red)
//                }
//            }
    }
}

//#Preview {
//    CategoryDetailView(category: .example)
//}
