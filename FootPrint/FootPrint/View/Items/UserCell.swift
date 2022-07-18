//
//  UserCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct UserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("\(user.username)")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("djLover")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}
