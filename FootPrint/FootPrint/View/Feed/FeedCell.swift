//
//  FeedCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/11.
//
// FeedCell for FeedView.swift

import SwiftUI

struct FeedCell: View {
    
    @State var numberOfHeart: Int = 1_000
    @State var numberOfComment: Int = 217
    
    @State var isHeartClicked: Bool = false
    @State var isClipped: Bool = false
    var body: some View {
        HStack {
            
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 180)
                .clipped()
                .padding(15)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                    
                    Text("username")
                }
                
                Text("담배가게 여행")
                    .padding([.top, .bottom])
                
                HStack {
                    VStack {
                        Button(action: {
                            isHeartClicked.toggle()
                        }, label: {
                            if isHeartClicked {
                                Image(systemName: "heart.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(4)
                                        .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(4)
                            }
                        })
                        
                        if numberOfHeart > 999 {
                            Text("999+")
                                .font(.system(size: 15))
                        } else {
                            Text(String(numberOfHeart))
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.trailing, 10)
                    
                    VStack {
                        Image(systemName: "bubble.left")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                        
                        if numberOfComment > 999 {
                            Text("999+")
                                .font(.system(size: 15))
                        } else {
                            Text(String(numberOfComment))
                                .font(.system(size: 15))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isClipped.toggle()
                    }, label: {
                        if isClipped {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                                .padding(.bottom, 25)
                                .padding(.trailing, 15)
                                .foregroundColor(.black)
                        }
                        else {
                            Image(systemName: "bookmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                                .padding(.bottom, 25)
                                .padding(.trailing, 15)
                                .foregroundColor(.black)
                        }
                    })
                }
            }
            Spacer()
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
