//
//  DayButton.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct DayButton: View {
    
    @State private var dayIndex: Int = 1
    var body: some View {
        Button(action: {}, label: {
            VStack {
                Text("Day " + String(dayIndex))
                    .foregroundColor(.black)
                    .font(.system(size: 15, weight: .semibold))
                    .padding([.leading, .top, .trailing])
                    .frame(width: 100)
                
                Rectangle()
                    .frame(width: 100, height: 3.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
            }
        })
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        DayButton()
    }
}
