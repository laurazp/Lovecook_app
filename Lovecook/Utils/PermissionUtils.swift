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
    
    var hasCameraPermission: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    func checkLibraryPermission(completion: @escaping (Bool) -> Void) async {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        if status == .authorized {
            completion(true)
        } else if status == .notDetermined {
            await PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                if newStatus == .authorized {
                    print("Access granted.")
                    completion(true)
                } else {
                    print("Access denied.")
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        print(status)
        
        switch status {
        case .notDetermined, .restricted, .denied:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    print("Access granted.")
                } else {
                    print("Access denied.")
                    //TODO: alert to go to settings
                }
            }
        case .authorized:
            print("Access already granted.")
        case .limited:
            print("Access limited.")
        @unknown default:
            print("Unknown authorization status.")
        }
    }
}
