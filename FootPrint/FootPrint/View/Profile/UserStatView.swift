//
//  UserStateView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))
            Text("\(title)")
                .font(.system(size: 15)).frame(width: 80, alignment: .center)
        }
        .frame(width: 80, alignment: .center) // 요소 간 스태틱한 width를 부여
    }
}
