//
//  DetailView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/12.
//

import SwiftUI

struct DetailView: View {
    
    @State var locName: String = "담배가게"
    @State var comment : String = "담배가 정말 맛있었던 곳"

    @State var isHeartClicked: Bool = false
    @State var isClipped: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipped()
                        .padding(.leading, 20)
                    
                    Text(locName)
                        .font(.system(size: 16, weight:
                                            .semibold))
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 10)
                
                // !! 이미지 여러장 넘기는 액션 필요
                // post image
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 400)
                    .clipped()
                
                // acton buttons
                HStack(spacing: 10) {
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
                    
                    Button(action: {}, label: {
                    Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(4)
                    })
                    
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
                .foregroundColor(.black)
                .padding()
                
                // Comment
                HStack {
                    Image(systemName: "bubble.left")
                    Text("Comment")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                Text(comment)
                    .padding(.leading, 30)
                    .padding(.top, 1)
                
                // Price info
                HStack {
                    Image(systemName: "tag")
                    Text("Price")
                    Spacer()
                }
                .padding()
                
                // Tips
                HStack {
                    Image(systemName: "questionmark")
                    Text("Tip")
                    Spacer()
                }
                .padding()
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
