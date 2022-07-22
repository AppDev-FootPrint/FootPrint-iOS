//
//  VisitedCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/05.
//
// travel_info에서 여행 정보 하나하나의 셀을 의미

import SwiftUI

struct VisitedCell: View {
    
    let detail: DetailTravel
    
    @State private var address : String = ""
    @State private var roadAddress : String = ""
    @State private var review : String = ""
    
    func getData() {
        self.address = detail.address ?? ""
        self.roadAddress = detail.roadAddress ?? ""
        self.review = detail.review ?? ""
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                Text(address)
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
                        Text(self.roadAddress)
                            .font(.system(size:12))
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Image(systemName: "bubble.right")
                        Text(self.review)
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
        .onAppear() {
            getData()
        }
    }
}
