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
    
    /*private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }*/
    
    func saveImage(data: Data/*, userId: String*/) async throws -> (path: String, name: String) {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await imagesReference.child(path).putDataAsync(data, metadata: metaData)
        //let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: metaData)

        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
}
