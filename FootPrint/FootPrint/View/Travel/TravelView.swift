//
//  TravelView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct TravelView: View {
    
    @State private var travelTitle: String = "TRAVEL TITLE"
    
    var body: some View {
        VStack {
            HStack {
                Text(travelTitle)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .padding(.trailing, 20)
            }
            VStack {
                HStack {
                    ForEach (0..<3) { _ in
                        DayButton()
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                }
            }
            
            ScrollView {
                ForEach (0..<3) { _ in
                    VisitedCell()
                }
            }
        }
    }
}

struct TravelView_Previews: PreviewProvider {
    static var previews: some View {
        TravelView()
    }
}
