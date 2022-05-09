//
//  TravelView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct TravelView: View {
    
    @State private var travelTitle: String = "TRAVEL TITLE"
    
    @State private var userState : Bool = true // 로그인한 계정의 travel이라면 true
    
    var body: some View {
        VStack {
            HStack {
                Text(travelTitle)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .padding(.trailing, 20)
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
                    VisitedCell()
                }
                
                NavigationLink(destination: CreateDetailInfoView(), label: {
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

struct TravelView_Previews: PreviewProvider {
    static var previews: some View {
        TravelView()
    }
}
