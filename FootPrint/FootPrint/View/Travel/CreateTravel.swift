//
//  CreateTravel.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI

struct CreateTravel: View {
    
    @State private var date = Date()
    @State var title: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Travel Title")
                    .font(.system(size: 15, weight: .semibold))
                    .padding([.leading, .top, .bottom])
                
                TextField("Enter the title", text: $title)
                    .padding()
            }
            .padding(.top)
            
            DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            
            HStack {
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Clear")
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color("gray"))
                        .cornerRadius(10)
                        .padding(.trailing, 10)
                })
                
                Button(action: {}, label: {
                    Text("Apply")
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color("blue"))
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                })
            }
            
            Spacer()
        }
    }
}

struct CreateTravel_Previews: PreviewProvider {
    static var previews: some View {
        CreateTravel()
    }
}
