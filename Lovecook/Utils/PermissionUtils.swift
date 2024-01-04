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
            // Permission already granted
            print("Access granted.")
            completion(true)
        } else {
            // Request permission
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    print("Access granted.")
                    completion(true)
                } else {
                    print("Access denied.")
                    //TODO: alert to go to settings
                    completion(false)
                }
            }
        }
    }
    
    func openPhotoPicker() {
        // Code to present the PhotosPicker or any other action after permission is granted
        // Here, you might set a flag or perform some action to display the picker
        print("opening the picker!!!!")
    }
    
    
    /*var hasCameraPermission: Bool {
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
     
     switch status {
     case .notDetermined, .restricted, .denied:
     PHPhotoLibrary.requestAuthorization { newStatus in
     if newStatus == .authorized {
     print("Access granted.")
     } else {
     print("Access denied.")
     //alert to go to settings
     }
     }
     case .authorized:
     print("Access already granted.")
     case .limited:
     print("Access limited.")
     @unknown default:
     print("Unknown authorization status.")
     }
     }*/
}
