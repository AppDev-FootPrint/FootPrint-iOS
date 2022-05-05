//
//  VisitedCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/05.
//
// travel_info에서 여행 정보 하나하나의 셀을 의미

import SwiftUI

struct VisitedCell: View {
    
    @State private var locName : String = "담배가게"
    @State private var locAddr : String = "대전 서구 송리단길 12번길 15"
    @State private var locComment : String = "담배가 정말 맛있었던 곳"
    
    @State private var photo: String = "photo"
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                Text(locName)
                    .font(.system(size: 15, weight: .semibold))
                
                Spacer()
            }
            .padding(.leading, 10)
            
            HStack {
                Rectangle()
                    .frame(width: 3, height: 100, alignment: .leading)
                    .background(Color("gray"))
                    .padding(.leading)
                
                VStack {
                    HStack {
                        Image(systemName: "location")
                        Text(locAddr)
                            .font(.system(size:12))
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Image(systemName: "bubble.right")
                        Text(locComment)
                            .font(.system(size:12))
                        
                        Spacer()
                    }
                }
                
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding(.trailing, 10)
            }
        }
        .padding()
    }
}

struct VisitedCell_Previews: PreviewProvider {
    static var previews: some View {
        VisitedCell()
    }
}
