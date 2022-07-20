//
//  UserListView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

// 기간 내 구현되지 않을 예정인 부분
struct UserListView: View {
    var users: [String]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users, id:\.self) { user in
                    UserCell(user: user)
                        .padding(.leading)
                }
            }
        }
    }
}
