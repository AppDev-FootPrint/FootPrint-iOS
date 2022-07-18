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
    @State private var isVisible: Bool = true
    
    @ObservedObject var viewModel = MainTravelViewModel(travel: MainTravel(likeNum: 0))
    @State var showToast = false // 게시글 등록 완룔 메시지
    @State var showWarning = false // 제목 입력 X시
    
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
                    isVisible.toggle()
                }, label: {
                    Image(systemName: isVisible ? "lock.open" : "lock")
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
                    if title.count == 0 {
                        showWarning = true
                    } else {
                        viewModel.createMainTravel(title: title, startDate: Date2String(date: startDate), endDate: Date2String(date: endDate), isVisible: isVisible, isCompleted: true, mainImagePath: "no_path\(Int.random(in: 0...1000))")
                    }
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
        .popup(isPresented: $showToast, type: .floater(), position: .bottom, autohideIn: 1.5) {
            Text("새 여행 등록 완료 :)")
                .frame(width: 200, height: 60)
                .foregroundColor(.white)
                .background(Color("blue"))
                .cornerRadius(30.0)
        }
        .popup(isPresented: $showWarning, type: .floater(), position: .bottom, autohideIn: 1.5) {
            Text("등록 실패!\n 제목을 입력해주세요 :(")
                .frame(width: 200, height: 60)
                .foregroundColor(.white)
                .background(Color("red"))
                .cornerRadius(30.0)
                .multilineTextAlignment(.center)
        }
    }
}
