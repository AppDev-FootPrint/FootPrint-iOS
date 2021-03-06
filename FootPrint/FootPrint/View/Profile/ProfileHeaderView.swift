//
//  ProfileHeaderView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                    .foregroundColor(.gray)
            
                Spacer()
            
                HStack(spacing: 16) {
                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Posts")
                    NavigationLink(destination: {
                        UserListView(users: viewModel.followers)
                    }, label: {
                        UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                    })
                    .foregroundColor(.black)
                    NavigationLink(destination: {
                        UserListView(users: viewModel.followings)
                    }, label: {
                        UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
                    })
                    .foregroundColor(.black)
                }
                .padding(.trailing)
            }
            
            VStack(alignment: .leading){
                HStack {
                    Text("\(viewModel.user.username)")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.leading, 25)
                        .padding(.bottom, 5)
                    
                    Spacer()
                }
                Text("요기는 자기소개란입니당")
                    .font(.system(size: 15))
                    .padding(.leading, 25)
                    .multilineTextAlignment(.leading)
            }
            ProfileActionButtonView(viewModel: viewModel)
        }
    }
}
