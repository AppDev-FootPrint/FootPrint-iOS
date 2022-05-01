//
//  ProfileActionButtonView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.


import SwiftUI

struct ProfileActionButtonView: View {
    
    var isCurrentUser = false
    var isFollowed = false
    
    var body: some View {
        if isCurrentUser {
            // edit profile button
            Button(action: {}, label: {
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 150, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            })
        } else {
            // show follow and messeage buttons
                Button(action: {}, label: {
                    Text(isFollowed ? "Following" : "Follow") // 삼항연산 사용
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 150, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                }).cornerRadius(3)
        }
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView()
    }
}
