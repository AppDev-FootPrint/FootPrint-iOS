//
//  FeedGridView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//
// figma : MainPage

import SwiftUI


struct FeedGridView: View {
    
    private let items = [GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 2
    
    @ObservedObject var viewModel : FeedViewModel
   
    var body: some View {
        LazyVGrid(columns: items, content: {
            ForEach (viewModel.travels) { travel in
               NavigationLink(
                destination: MainTravelView(viewModel: MainTravelViewModel(travel: travel)),
                label: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width - 10, height: width - 10)
                        .clipped()
                        .foregroundColor(.gray)
                })
            }
        })
    }
}
