//
//  SecureTextField.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/10.
//

import SwiftUI

struct CustomSecureField: View {
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
            
            SecureField("\(placeholder)...", text: $text)
                .padding()
                .border(.black, width:2)
                .padding([.leading, .trailing, .bottom])
        }
    }
}
