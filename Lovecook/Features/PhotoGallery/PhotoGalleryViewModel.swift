//
//  PhotoGalleryViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import SwiftUI
import FirebaseStorage
import _PhotosUI_SwiftUI

class PhotoGalleryViewModel: ObservableObject {
    
    private let storage = Storage.storage().reference()
    
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    @MainActor
    func getPhotosFromFirebase() {
        photos.removeAll()
        
        let storageRef = storage.child("images")
        
        storageRef.listAll { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let result = result {
                for item in result.items {
                    
                    item.downloadURL { (url, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            item.getMetadata { metadata, _ in
                                if let downloadURL = url {
                                    self.photos.append(
                                        Photo(url: downloadURL, name: metadata?.customMetadata?["title"] ?? item.name))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func saveUserImage(item: PhotosPickerItem, title: String, completion: @escaping (String) -> Void) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name, title) = try await StorageManager.shared.saveImage(data: data, title: title)
            let storageRef = storage.child("images").child(name)
            storageRef.downloadURL(completion: { [unowned self] (url, error) in
                guard error == nil, let url = url else {
                    return
                }
                self.photos.append(Photo(url: url, name: title ?? name))
                completion("")
            })
        }
    }
}
