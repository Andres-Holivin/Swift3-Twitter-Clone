//
//  User.swift
//  CloneTwitter
//
//  Created by andres holivin on 19/06/22.
//

import FirebaseFirestoreSwift

struct UserModel: Identifiable,Decodable{
    
    @DocumentID var id: String?
    let username:String
    let fullname:String
    let profileImageUrl:String
    let email:String
    
    
    
}
