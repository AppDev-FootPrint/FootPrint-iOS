//
//  FeedView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/11.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            ForEach (viewModel.travels) { travel in
                NavigationLink (destination: MainTravelView(viewModel: MainTravelViewModel(travel: travel)), label: {
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
