//
//  DayButton.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct CategoryButton: View {
    
    var categoryName: String = "category"
    
    var body: some View {
        Button(action: {}, label: {
            VStack {
                Text(categoryName)
                    .foregroundColor(.black)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 90)
                
                Rectangle()
                    .frame(width: 80, height: 3.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
            }
        })
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton()
    }
}
