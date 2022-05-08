//
//  UserListView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct SearchListView: View {
    
    @State private var category : String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                NavigationLink (
                    destination: ProfileView(),
                    label: {
                        LocationCell(locationName: "성심당 본점", locationAddress: "대전 중구 은행동")
                            .padding(.leading)
                })
                NavigationLink (
                    destination: ProfileView(),
                    label: {
                        LocationCell(locationName: "성심당 케익부띠끄", locationAddress: "대전 중구 은행동")
                            .padding(.leading)
                })
                NavigationLink (
                    destination: ProfileView(),
                    label: {
                        LocationCell(locationName: "성심당 DCC점", locationAddress: "대전 유성구 도룡동")
                            .padding(.leading)
                })
                NavigationLink (
                    destination: ProfileView(),
                    label: {
                        UserCell()
                            .padding(.leading)
                })
            }
            .foregroundColor(.black)
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
