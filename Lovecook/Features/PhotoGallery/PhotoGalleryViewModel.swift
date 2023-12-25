//
//  PhotoGalleryViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import Foundation
import _PhotosUI_SwiftUI

class PhotoGalleryViewModel: ObservableObject {
    
    private let getPhotosUseCase: GetPhotosUseCase
    @Published var photos: [String] = [] //TODO: Revisar tipo
    @Published var isLoading = false
    @Published var error: Error?
    
    init(getPhotosUseCase: GetPhotosUseCase) {
        self.getPhotosUseCase = getPhotosUseCase
    }
    
    @MainActor
    func getPhotos() async {
        error = nil
        isLoading = true
        
        do {
            photos = try await getPhotosUseCase.execute()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
    func saveUserImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name) = try await StorageManager.shared.saveImage(data: data/*, userId: user.userId*/)
            print("SUCCESS!")
            print(path)
            print(name)
        }
    }
}
