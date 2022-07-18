//
//  SearchBar.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            if isEditing {
                Button(action: {
                    withAnimation(.default) {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                }}, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                })
                    .transition(.move(edge: .leading))
            }
            
            TextField("Search..", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                })
                .onTapGesture {
                    isEditing = true
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Text"), isEditing: .constant(false))
    }
}
