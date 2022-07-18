//
//  ProfileActionButtonView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.


import SwiftUI

struct ProfileActionButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowed : Bool { return viewModel.user.isFollowed ?? false}
    @State private var showEditProfile = false
    private let width = UIScreen.main.bounds.width / 2 - 10
    
    var body: some View {
        if viewModel.user.isCurrentUser { // 로그인한 유저 본인의 프로필이라면 edit profile, setting button을 show
            HStack {
                // edit profile button
                Button(action: { showEditProfile.toggle() }, label: {
                    Text("Edit Profile")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 170, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.trailing, 10)
                }).sheet(isPresented: $showEditProfile, content: {
                    // bio 수정용
                })
                
                // private setting button
                NavigationLink(destination: PrivateSettingView(), label: {
                    HStack {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 170, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                })
            }
        } else {
            HStack {
                // 현재 로그인한 유저가 아닌 다른 유저의 프로필이하면 shows buttons for follow and messeage
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                    
                }, label: {
                    Text(isFollowed ? "Following" : "Follow") // 삼항연산 사용
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: self.width, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                    }).cornerRadius(3)
                
                Button(action: {}, label: {
                    Text("Messaage")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: self.width, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                    )
                })
            }
        }
    }
}
