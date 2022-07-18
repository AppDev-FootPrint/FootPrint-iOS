//
//  UserListView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

// 기간 내 구현되지 않을 예정인 부분
struct SearchListView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    var travels: [MainTravel] {
        return searchText.isEmpty ? viewModel.travels : viewModel.filteredHistories(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.travels) { travel in
                    NavigationLink (
                        destination: EmptyView(),
                        label: {
//                            UserCell(user: user)
//                                .padding(.leading)
                    })
                }
            }
        }
    }
}
