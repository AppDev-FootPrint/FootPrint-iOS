//
//  ProfileHeaderView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
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
            
            HStack {
                VStack {
                    Text("username")
                        .font(.system(size: 15, weight: .semibold))
                        .padding([.leading, .top])
                    
                    Text("자기소개란")
                        .font(.system(size: 15))
                        .padding(.leading)
                        .padding(.top, 1)
                }
                
                Spacer()
                
                ProfileActionButtonView()
                    .padding(.trailing)
            }
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
