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
    
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var error: Error?
    //@Published var refreshView = false
    
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
                                self.photos.append(
                                    Photo(url: downloadURL, name: item.name)
                                )
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
            //refreshView.toggle()
            //await getPhotosFromFirebase()
            print("SUCCESS!")
            print(path)
            print(name)
            // Retrieve uploaded image path and append to current photos
            let storageRef = storage.child("images").child(name)
            storageRef.downloadURL(completion: { [unowned self] (url, error) in
                guard error == nil, let url = url else {
                    print("Failed to download url:", error!)
                    return
                }
                self.photos.append(Photo(url: url, name: name))
            })
        }
    }
    
    //TODO: revisar!!
    func delete() {
        let storageRef = storage.child("images")

        // Delete the file
        storageRef.delete {error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}
