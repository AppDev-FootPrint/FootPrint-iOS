//
//  ProfileView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    @ObservedObject var viewModel : ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
            ScrollView {
                VStack {
                    ProfileHeaderView(viewModel: viewModel)
                    FeedGridView()
                    Spacer()
                }
        }
    }
}
