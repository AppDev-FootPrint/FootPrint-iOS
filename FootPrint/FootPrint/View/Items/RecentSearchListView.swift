//
//  RecentSearchListView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct RecentSearchListView: View {
    var body: some View {
        ScrollView {
            HStack {
                Text("Recent History")
                    .padding(.leading)
                
                Spacer()
                
                NavigationLink(destination: {}, label: {
                    Text("View all")
                        .padding(.trailing)
                })
            }
            LazyVStack {
                NavigationLink (
                    destination: {},
                    label: {
                        HistoryCell(searchKeyword: "Hello world !")
                            .padding(5)
                            .padding(.leading, 10)
                })
                NavigationLink (
                    destination: {},
                    label: {
                        HistoryCell(searchKeyword: "Bye world !")
                            .padding(5)
                            .padding(.leading, 10)
                })
            }
        }
    }
}

struct RecentSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchListView()
    }
}
