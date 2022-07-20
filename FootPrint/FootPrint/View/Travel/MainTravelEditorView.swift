//
//  CreateTravel.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/01.
//

import SwiftUI
import PopupView

struct MainTravelEditorView: View {
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var title: String = ""
    @State private var isVisible: Bool = true
    
    @Binding var editingMode: Bool // true: create, false: update
    @ObservedObject var viewModel : MainTravelViewModel
    @State var showToast = false // 게시글 등록 완룔 메시지
    @State var showTitleWarning = false // 제목 입력 X시 true
    @State var showDateWarning = false // 날짜가 startDate > endDate시 true
    
    init(editingMode: Binding<Bool>, viewModel: MainTravelViewModel) {
        self._editingMode = editingMode
        self.viewModel = viewModel
        
        if _editingMode.wrappedValue {
            title = viewModel.travel.title!
            // 빈칸이면 등록할 수 없도록 예외처리했으므로 강제언래핑
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Travel Title")
                    .font(.system(size: 15, weight: .semibold))
                    .padding([.leading, .bottom])
                
                TextField(editingMode ? "\(viewModel.travel.title ?? "")" : "Enter the title", text: $title)
                    .padding([[.leading, .trailing, .bottom]])
            }
            .padding(.top)
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .font(.system(size: 15, weight: .semibold))
                .padding()
            DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                .font(.system(size: 15, weight: .semibold))
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
                        if editingMode {
                            self.title = viewModel.travel.title!
                        } else {
                            showTitleWarning = true
                        }
                    } else if startDate > endDate {
                        showDateWarning = true
                    }
                    else {
                        if editingMode {
                            let travel = viewModel.travel
                            viewModel.modifyTravel(travelId: travel.id!, title: self.title, startDate: Date2String(date: self.startDate), endDate: Date2String(date: self.endDate), isVisible: self.isVisible, isCompleted: true, mainImagePath: "no_path\(Int.random(in: 0...1000))", createdAt: travel.createdAt ?? "", writerInfo: WriterInfo(id: travel.writerInfo?.id ?? 0, username: travel.writerInfo?.username ?? "", nickname: travel.writerInfo?.nickname ?? ""), didLike: travel.didLike ?? false)
                        } else {
                            viewModel.createMainTravel(title: title, startDate: Date2String(date: startDate), endDate: Date2String(date: endDate), isVisible: isVisible, isCompleted: true, mainImagePath: "no_path\(Int.random(in: 0...1000))")
                        }
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
                        print(completed)
                        showToast = true
                    }
                })
            }
            Spacer()
        }
        .popup(isPresented: $showToast, type: .floater(), position: .bottom, autohideIn: 1.5) {
            Text("새 여행 등록 완료 :)")
                .frame(width: editingMode ? 150 : 200, height: 60)
                .foregroundColor(.white)
                .background(Color("blue"))
                .cornerRadius(30.0)
        }
        .popup(isPresented: $showTitleWarning, type: .floater(), position: .bottom, autohideIn: 1.5) {
            Text("등록 실패!\n 제목을 입력해주세요 :(")
                .frame(width: 200, height: 60)
                .foregroundColor(.white)
                .background(Color("red"))
                .cornerRadius(30.0)
                .multilineTextAlignment(.center)
        }
        .popup(isPresented: $showDateWarning, type: .floater(), position: .bottom, autohideIn: 1.5) {
            Text("등록 실패!\n 시작 날짜가 종료 날짜 이전이어야 해요 :(")
                .frame(width: 320, height: 60)
                .foregroundColor(.white)
                .background(Color("red"))
                .cornerRadius(30.0)
                .multilineTextAlignment(.center)
        }
        .onAppear {
            if editingMode {
                viewModel.fetchMainTravel(id: viewModel.travel.id!) { completion in
                    startDate = String2Date(date: viewModel.travel.startDate!)
                    endDate = String2Date(date: viewModel.travel.endDate!)
                    isVisible = viewModel.travel.isVisible!
                }
            }
        }
    }
}
