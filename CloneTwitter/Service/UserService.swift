//
//  UserService.swift
//  CloneTwitter
//
//  Created by andres holivin on 19/06/22.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct UserServices{
    func fetchUser(withUid uid: String,complition : @escaping(UserModel)->Void){
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument{snapshot,_ in
                
                guard let snapshot =  snapshot else {return}
                
                guard let user = try? snapshot.data(as: UserModel.self) else {return}
                
                complition(user)
            }
    }
    func fetchUsers(completion:@escaping([UserModel])-> Void){
        var users=[UserModel]()
        Firestore.firestore().collection("users")
            .getDocuments{snapshot,_ in
                guard let documents = snapshot?.documents else {return}
                let users = documents.compactMap({try? $0.data(as: UserModel.self)})
                
                completion(users)
            }
    }
}
