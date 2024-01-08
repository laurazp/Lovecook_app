//
//  Category.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

struct Category: Decodable, Identifiable {
    var id: String {
        categoryId
    }
    let categoryId: String
    let categoryTitle: String
    let categoryImage: String
    let categoryDescription: String
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "idCategory"
        case categoryTitle = "strCategory"
        case categoryImage = "strCategoryThumb"
        case categoryDescription = "strCategoryDescription"
    }
    
    static var example: Category {
        return Category(
            categoryId: "1",
            categoryTitle: "Beef",
            categoryImage: "https://www.themealdb.com/images/category/beef.png",
            categoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times. Beef is a source of high-quality protein and essential nutrients."
        )
    }
}
