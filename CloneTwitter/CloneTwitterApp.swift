//
//  CloneTwitterApp.swift
//  CloneTwitter
//
//  Created by andres holivin on 04/06/22.
//

import SwiftUI
import Firebase

@main
struct CloneTwitterApp: App {
    @StateObject var viewModel=AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
