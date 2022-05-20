//
//  NotificationCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/20.
//

import SwiftUI

struct NotificationCell: View {
    
    @State private var username : String = "honey__ney_"
    @State private var notificatedDay : Date = Date()
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 50, height: 50)
            Text("\(username)님이 회원님의 스토리를 좋아합니다.")
            
            Image(systemName: "square")
                .resizable()
                .frame(width: 50, height: 50)
            
        }
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
