//
//  RemoteImageView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 28/12/23.
//

import SwiftUI

struct RemoteImageView: View {
    let downloadURL: URL
    @State private var imageData: Data?
    
    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 110, height: 120)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
        } else {
            ProgressView() //TODO: Placeholder while loading or if there's an error ??
                .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        URLSession.shared.dataTask(with: downloadURL) { data, _, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
    }
}
