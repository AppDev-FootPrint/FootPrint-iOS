//
//  LocationCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct LocationCell: View {
    
    var locationName : String
    var locationAddress : String
    
    var body: some View {
        HStack {
            // image
            Image(systemName: "leaf.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(locationName)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(locationAddress)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(locationName: "대전 성심당", locationAddress: "대전 중구 은행동")
    }
}
