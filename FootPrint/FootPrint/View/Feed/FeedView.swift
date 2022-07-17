//
//  FeedView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/11.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            ForEach (0..<10) { _ in
                NavigationLink (destination: MainTravelView(), label: {
                    FeedCell()
                        .foregroundColor(.black)
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
