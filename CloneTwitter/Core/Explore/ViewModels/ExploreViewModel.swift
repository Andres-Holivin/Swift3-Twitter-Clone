//
//  ExploreViewModel.swift
//  CloneTwitter
//
//  Created by andres holivin on 26/06/22.
//

import Foundation
class ExploreViewModel: ObservableObject{
    @Published var users = [UserModel]()
    @Published var searchText = ""
    var searchableUser: [UserModel]{
        if searchText.isEmpty{
            return users
        }else{
            let lowercasetQuery = searchText.lowercased()
            return users.filter({
                $0.username.contains(lowercasetQuery) ||
                $0.fullname.lowercased().contains(lowercasetQuery)
            })
        }
            
    }
    
    let service = UserServices()
    
    init() {
        fetchUsers()
    }
    func fetchUsers(){
        service.fetchUsers{users in
            self.users = users
            print("Debug: Users\(users)")
            
        }
    }
}
