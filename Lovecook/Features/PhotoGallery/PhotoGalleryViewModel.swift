//
//  PhotoGalleryViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import Foundation
import FirebaseStorage
import _PhotosUI_SwiftUI

class PhotoGalleryViewModel: ObservableObject {
    
    private let storage = Storage.storage().reference()
    
    @Published var photos: [URL] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    @MainActor
    func getPhotosFromFirebase() {
        let storageRef = storage.child("images")
        
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all files: ", error)
            }
            
            if let result = result {
                for item in result.items {
                    
                    item.downloadURL { (url, error) in
                        if let error = error {
                            print("Error getting download URL: \(error)")
                        } else {
                            if let downloadURL = url {
                                self.photos.append(downloadURL)
                                print("Download URL: \(downloadURL)")
                            }
                        }
                    }
                }
            }
        }
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
