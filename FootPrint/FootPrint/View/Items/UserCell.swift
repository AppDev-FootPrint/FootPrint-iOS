//
//  UserCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("대전 소개하는 사람")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("djLover")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
