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
    
    enum categories: String, CaseIterable {
        case Popular
        case Account
        case Hashtag
        case Location
    }
    
    var body: some View {
        ScrollView {
            // search bar
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            if inSearchMode {
                HStack {
                    ForEach(categories.allCases, id: \.rawValue) { category in
                        CategoryButton(categoryName: category.rawValue)
                    }
                }
                .padding(.bottom)
            }
            
            // grid view/ grid user
            ZStack {
                // 서치모드면 검색한 유저리스트가 보이도록, 아니면 검색 history 리스트 보여야 함
                if inSearchMode {
                    SearchListView()
                } else {
                    RecentSearchListView()
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
