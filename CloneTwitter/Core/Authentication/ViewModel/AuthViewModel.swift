//
//  AuthViewModel.swift
//  CloneTwitter
//
//  Created by andres holivin on 18/06/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel : ObservableObject{
    @Published var userSession: User?
    @Published var didAuthUser = false
    @Published var currentUser : UserModel?
    private var tempUserSession: User?
    private let service = UserServices()
    init(){
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    func login(withEmail email:String , password : String){
        Auth.auth().signIn(withEmail: email, password: password){result,error in
            if let error = error{
                print("Debug: failed to sign in with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()            
        }
    }
    func register(withEmail email:String, password: String, fullname:String, username:String){
        Auth.auth().createUser(withEmail: email, password: password){result,error in
            if let error = error{
                print("Debug: Failed to register with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return }
            
            self.tempUserSession = user
            
            let data=["email":email,
                      "username":username.lowercased(),
                      "fullname":fullname,
                      "uid":user.uid]
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data){_ in
                    self.didAuthUser=true
                }
        }
    }
    func signOut(){
        userSession=nil
        try? Auth.auth().signOut()
    }
    func uploadProfileImage(_ image:UIImage){
        guard let uid = tempUserSession?.uid else {return}
        
        ImageUploader.uploadImage(image: image){profileImageUrl in
            Firestore
                .firestore()
                .collection("users")
                .document(uid)
                .updateData(["profileImageUrl":profileImageUrl]){_ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    func fetchUser(){
        guard let uid = self.userSession?.uid else {return}
        print("Debug: uid:\(uid)")
        service.fetchUser(withUid: uid){user in
            
            self.currentUser=user
        }
    }
    
}
