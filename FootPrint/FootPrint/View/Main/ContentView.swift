//
//  ContentView.swift
//  FootPrint
//
//  Created by 문다 on 2022/04/27.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            }
            else {
                if let user = viewModel.userSession {
                    MainTabView(user: user)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
