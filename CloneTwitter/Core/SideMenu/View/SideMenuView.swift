//
//  SideMenuView.swift
//  CloneTwitter
//
//  Created by andres holivin on 05/06/22.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            VStack (alignment:.leading,spacing : 32){
                VStack(alignment: .leading){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width:48,height:48)
                    
                    VStack(alignment:.leading, spacing:4){
                        Text(user.fullname)
                            .font(.headline)
                        Text("@\(user.username)")
                            .font(.caption)
                        
                    }
                    UserStatsView()
                        .padding(.vertical)
                }
                .padding(.leading)
                
                ForEach(SideMenuViewModel.allCases,id: \.rawValue) { option in
                    if option == .profile{
                        NavigationLink{
                            ProfileView(user:viewModel.currentUser!)
                        }label:{
                            SideMenuOptionRowView(viewModel : option)
                        }
                    }else if (option == .logout){
                        Button{
                            viewModel.signOut()
                        }label: {
                            SideMenuOptionRowView(viewModel: option)
                        }
                    }else{
                        SideMenuOptionRowView(viewModel: option)
                    }
                    
                }
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
