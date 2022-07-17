//
//  TravelView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//
// figma : Travel_infos

import SwiftUI

struct MainTravelView: View {
    
    @State private var travelTitle: String = "TRAVEL TITLE"
    
    @State private var userState : Bool = true // 로그인한 계정의 travel이라면 true
    @State private var clipped: Bool = true // 여행을 따로 저장? 디폴트는 false (저장하지 않은 상태)
    
    @ObservedObject var viewModel : MainTravelViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(travelTitle)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                if !userState { // 사용자의 여행글이 아닌 다른 사람의 게시글인 경우 
                    if !clipped { // 스크랩하지 않은 경우
                        Image(systemName: "bookmark")
                    } else { // 스크랩한 경우
                        Image(systemName: "bookmark.fill")
                    }
                } else { // 사용자 본인의 글인 경우
                    Menu(content: {
                        Button(action: {}, label: {
                            Label("Modify", systemImage: "pencil")
                        })

                        Button(action: {}, label: {
                            Label("Delete", systemImage: "delete.left")
                        })
                    }, label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .padding(.trailing, 20)
                            .foregroundColor(.black)
                    })
                }
            }
            
            HStack {
                ForEach (1..<4) { idx in
                    CategoryButton(categoryName: "Day" + String(idx))
                        .padding([.leading, .trailing], 10)
                        .padding(.top)
                }
            }
            
            ScrollView {
                ForEach (0..<3) { _ in
                    NavigationLink (destination: DetailTravelView(), label: {
                        VisitedCell()
                            .foregroundColor(.black)
                    })
                }
                
                NavigationLink(destination: CreateDetailTravelView(numberOfPriceInfo: 0, numberOfTipInfo: 0), label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(50)
                })
            }
        }
    }
}
