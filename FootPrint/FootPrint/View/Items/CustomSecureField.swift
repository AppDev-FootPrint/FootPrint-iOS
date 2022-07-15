//
//  SecureTextField.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/10.
//

import SwiftUI

struct CustomSecureField: View {
    let placeholder: Text
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, 40)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                SecureField("", text: $text)
            }
        }
    }
}
