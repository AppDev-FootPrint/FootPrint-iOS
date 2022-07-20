//
//  UserCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct UserCell: View {
    
    let user: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text("\(user)")
                .font(.system(size: 15, weight: .semibold))
                .padding(.leading, 10)
            
            Spacer()
        }
    }
}
