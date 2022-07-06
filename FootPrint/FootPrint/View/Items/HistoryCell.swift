//
//  HistoryCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct HistoryCell: View {
    
    var searchKeyword: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            Text("Hello world")
                .font(.system(size: 14))

            Spacer()
        }
        .foregroundColor(.black)
    }
}

struct HistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCell(searchKeyword: "Hello world !")
    }
}
