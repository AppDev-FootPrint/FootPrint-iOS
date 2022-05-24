//
//  PriceCell.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/17.
//

import SwiftUI

struct PriceCell: View {
    
    @State private var isEdited : Bool = true
    @State private var content : String = ""
    @State private var price : String = ""
    
    // true: 글 작성 중의 가격셀, false : 게시글 조회 중의 가격 셀
    var body: some View {
        HStack {
            TextField("contents...", text: $content)
                .padding(10)
                .border(.gray, width: 1)
                .padding(.leading)
            
            TextField("price...", text: $price)
                .frame(width: 80)
                .padding(10)
                .border(.gray, width: 1)
                .padding(.trailing)
        }
    }
}

struct PriceCell_Previews: PreviewProvider {
    static var previews: some View {
        PriceCell()
    }
}
