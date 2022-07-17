//
//  CreateTravel.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI
import PopupView

struct CreateMainTravelView: View {
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var title: String = ""
    @State private var isPrivate: Bool = false
    
    @ObservedObject var viewModel = UploadTravelViewModel()
    @State var showToast = false
    
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
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .padding()
            DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                .padding()
            
            HStack {
                
                Spacer()
        
                // default: 공개 게시글
                Button(action: {
                    if isPrivate {
                        isPrivate = false
                    } else {
                        isPrivate = true
                    }
                }, label: {
                    Image(systemName: isPrivate ? "lock" : "lock.open")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(5)
                })
                
                Button(action: {}, label: {
                    Text("Clear")
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color("gray"))
                        .cornerRadius(10)
                        .padding(.trailing, 10)
                })
                
                // 새 여행 피드가 생성된 프로필 뷰로 전환
                Button(action: {
                    viewModel.createMainTravel(title: title, startDate: Date2String(date: startDate), endDate: Date2String(date: endDate), isVisible: isPrivate, isCompleted: true, mainImagePath: "no_path\(Int.random(in: 0...1000))")
                }, label: {
                    Text("Apply")
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color("blue"))
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                })
                .onReceive(viewModel.$created, perform: { completed in
                    if completed {
                        showToast = true
                    }
                })
            }
            
            Spacer()
        }
        .popup(isPresented: $showToast, type: .floater(), position: .bottom, autohideIn: 2) {
            Text("새 여행 등록 완료 :)")
                .frame(width: 200, height: 60)
                .foregroundColor(.white)
                .background(Color("blue"))
                .cornerRadius(30.0)
        }
    }
}

struct CreateMainTravelView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMainTravelView()
    }
}
