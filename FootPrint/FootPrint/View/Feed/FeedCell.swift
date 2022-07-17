//
//  FeedCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/11.
//
// FeedCell for FeedView.swift

import SwiftUI

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel

    @State var isClipped: Bool = false
    
    var didLike: Bool { return viewModel.travel.didLike ?? false }
    var numberOfLike: Int { return viewModel.travel.likeNum ?? 1_000 }
    var numberOfComment: Int { return viewModel.travel.commentCount ?? 0 }
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Image("thumbnail")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 180)
                .clipped()
                .cornerRadius(10)
                .padding([.leading, .top, .bottom], 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    
                    Text("\(viewModel.travel.writerInfo?.username ?? "username")")
                }
                
                Text("\(viewModel.travel.title ?? "no_title")")
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                
                HStack {
                    VStack {
                        Button(action: {
                            didLike ? viewModel.unlike() : viewModel.like()
                        }, label: {
                            Image(systemName: didLike ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .foregroundColor(didLike ? .red : .black)
                        })

                        
                        if numberOfLike > 999 {
                            Text("999+")
                                .font(.system(size: 15))
                        } else {
                            Text(String(numberOfLike))
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.trailing, 10)
                    
                    VStack {
                        Image(systemName: "bubble.left")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                            .onTapGesture {
                                
                            }
                        
                        if numberOfComment > 999 {
                            Text("999+")
                                .font(.system(size: 15))
                        } else {
                            Text(String(numberOfComment))
                                .font(.system(size: 15))
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: isClipped ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding(.bottom, 25)
                        .padding(.trailing, 15)
                        .foregroundColor(.black)
                        .onTapGesture {
                            isClipped.toggle()
                    }
                }
            }
            Spacer()
        }
    }
}
