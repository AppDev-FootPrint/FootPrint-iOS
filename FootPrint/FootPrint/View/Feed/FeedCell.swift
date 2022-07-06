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
                    
                    Text("username")
                }
                
                Text("담배가게 여행")
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                
                HStack {
                    VStack {
                        Image(systemName: isHeartClicked ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(isHeartClicked ? .red : .black)
                            .onTapGesture {
                                isHeartClicked.toggle()
                            }

                        
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

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
