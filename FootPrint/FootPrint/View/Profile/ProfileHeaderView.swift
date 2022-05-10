//
//  ProfileHeaderView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct ProfileHeaderView: View {
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
                    UserStatView(value: 1, title: "Posts")
                    UserStatView(value: 458, title: "Followers")
                    UserStatView(value: 324, title: "Following")
                }
                .padding(.trailing)
            }
            
            VStack (alignment: .leading) {
                Text("username")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.top)
                    .padding(.leading, 10)
                    
                Text("요기는 자기소개란입니당 자기소개랑 자기소개랑 자기소개 자기소개랑 자기소개랑 자기소개 자기소개랑 자기소개랑 자기소개")
                    .font(.system(size: 15))
                    .padding([.top,.leading, .trailing],5)
            }
            ProfileActionButtonView()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
