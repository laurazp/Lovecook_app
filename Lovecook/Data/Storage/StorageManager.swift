//
//  StorageManager.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    func saveImage(data: Data, title: String? = nil) async throws -> (path: String, name: String, title: String?) {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        if let title {
            metaData.customMetadata = ["title": title]
        }
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await imagesReference.child(path).putDataAsync(data, metadata: metaData)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName, title)
    }
}
