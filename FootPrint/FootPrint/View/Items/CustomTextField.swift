//
//  CustomTextField.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/09.
//

import SwiftUI

struct CustomTextField: View {
    
    var placeholder : String
    @Binding var text: String
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text(placeholder)
                    .font(.system(size: 18, weight: .semibold))
                    .padding([.leading, .trailing])
                Spacer()
            }
            
            TextField("\(placeholder)...", text: $text)
                .padding()
                .border(.black, width:2)
                .padding([.leading, .trailing, .bottom])
        }
    }
}
