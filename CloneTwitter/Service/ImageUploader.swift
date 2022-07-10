//
//  ImageUploader.swift
//  CloneTwitter
//
//  Created by andres holivin on 19/06/22.
//

import Firebase
import UIKit
import FirebaseStorage

struct ImageUploader{
    
    static func uploadImage(image:UIImage,completion: @escaping(String)->Void){
        guard let imageData=image.jpegData(compressionQuality: 0.5)else{return}
        let filename=NSUUID().uuidString
        let ref = Storage.storage().reference().child("/profile_image/\(filename)")
        
        ref.putData(imageData,metadata: nil){_,error in
            if let error = error{
                print("Debug: Failed to upload image with error \(error.localizedDescription)")
                return
            }
            ref.downloadURL{imageUrl,_ in
                guard let imageUrl = imageUrl?.absoluteString else{return}
                completion(imageUrl)
            }
        }
    }
}


