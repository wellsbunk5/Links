//
//  ImageUploader.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, error in
                if let error = error {
                    print("DEBUG: Failed to download image with error: \(error.localizedDescription)")
                    return
                }
                
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
    static func uploadImages(imagesData: [Data], completion: @escaping([String]) -> Void) {
        var imageUrls = [String]()
        for imageData in imagesData {
            let filename = NSUUID().uuidString
            let ref = Storage.storage().reference(withPath: "/golf_round_images/\(filename)")
            
            ref.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                    return
                }
                
                ref.downloadURL { imageUrl, error in
                    if let error = error {
                        print("DEBUG: Failed to download image with error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let imageUrl = imageUrl?.absoluteString else { return }
                    imageUrls.append(imageUrl)
                    completion(imageUrls)
                }
            }
        }
    }
}
