//
//  PermissionUtils.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 3/1/24.
//

import Foundation
import AVFoundation
import Photos

struct PermissionUtils {
    
    var hasPhotoLibraryPermission: Bool {
        get async {
            let status = PHPhotoLibrary.authorizationStatus()
            
            let isAuthorized = status == .authorized
            
            return isAuthorized
        }
    }
    
    func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) async {
        if await hasPhotoLibraryPermission {
            completion(true)
        } else {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
