//
//  SearchView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel = SearchViewModel() // helps populate view
    
    var body: some View {
        ScrollView {
            // search bar
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            // grid view/ list of users
            ZStack {
                if inSearchMode {
                    SearchListView(viewModel: viewModel, searchText: $searchText) // 구현되지않은 부분 
                } else {
                    FeedGridView(config: .explore)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
