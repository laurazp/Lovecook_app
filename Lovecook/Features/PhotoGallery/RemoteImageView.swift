//
//  RemoteImageView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 28/12/23.
//

import SwiftUI
import Toast

struct RemoteImageView: View {
    
    private struct Layout {
        static let errorToastImageName = "exclamationmark.octagon"
        static let errorToastText = "Error downloading image: "
    }
    
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
            ProgressView()
                .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        URLSession.shared.dataTask(with: downloadURL) { data, _, error in
            if let error = error {
                Toast.default(
                    image: UIImage(systemName: Layout.errorToastImageName)!,
                    title: ("\(Layout.errorToastText)\(error)")).show()
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
