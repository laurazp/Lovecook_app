//
//  UserNetworkImage.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import SwiftUI

struct UserNetworkImage: View {
    let url: URL?
    
    var body: some View {
        if let url = url,
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.lightGreen)        }
    }
}
