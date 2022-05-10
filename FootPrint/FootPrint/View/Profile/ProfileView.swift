//
//  ProfileView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var username : String = "username"
    var body: some View {
            ScrollView {
                VStack {
                    ProfileHeaderView()
                    FeedGridView()
                    Spacer()
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
