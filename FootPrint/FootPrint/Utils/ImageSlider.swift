//
//  ImageSlider.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/06.
//
import SwiftUI

struct ImageSlider: View {
    
    private let images = ["1", "2", "3", "4"]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                 Image(item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        // 이미지 이름을 id: \.self (index)와 숫자를 맞춰야 tabViewStyle이 적용되는데 나중에 수정 필요
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        // 4
        ImageSlider()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
