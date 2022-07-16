//
//  MainTabView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct MainTabView: View {
    let user: User 
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                CreateTravelView()
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                
                NotificationView()
//                TravelView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: logoutButton)
            .accentColor(.black)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
    var logoutButton: some View {
        Button {
            AuthViewModel.shared.signout()
        } label : {
            Text("Logout").foregroundColor(.black)
        }
    }

}
