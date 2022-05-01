//
//  ProfileView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView()
                FeedGridView()
            }
            .padding(.top)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
