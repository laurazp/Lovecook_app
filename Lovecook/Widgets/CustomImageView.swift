//
//  CustomImageView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 2/1/24.
//

import SwiftUI
import Kingfisher

struct CustomImageView: View {
    let imageURL: String
    let placeholder: String

    var body: some View {
        if let url = URL(string: imageURL), !imageURL.isEmpty {
            KFImage(url)
                .resizable()
        } else {
            Image(placeholder)
                .resizable()
        }
    }
}

#Preview {
    CustomImageView(imageURL: "", placeholder: "meal_placeholder")
}
