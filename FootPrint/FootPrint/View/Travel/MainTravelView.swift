//
//  TravelView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//
// figma : Travel_infos

import SwiftUI
import PopupView

struct MainTravelView: View {
    
    @State private var travelTitle: String = "TRAVEL TITLE"
    var userState : Bool { // 로그인한 계정의 travel이라면 true
        if viewModel.travel.writerInfo?.id == AuthViewModel.shared.userSession?.id {
            return true
        }
        return false
    }
    @State private var clipped: Bool = true // 여행을 따로 저장? 디폴트는 false (저장하지 않은 상태)
    @State private var editorMode: Bool = false // main travel 수정을 위한 뷰에 대한 모드
    
    @ObservedObject var viewModel : MainTravelViewModel
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            HStack {
                Text(travelTitle)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                if !userState { // 사용자의 여행글이 아닌 다른 사람의 게시글인 경우 
                    if !clipped { // 스크랩하지 않은 경우
                        Image(systemName: "bookmark")
                            .padding(.trailing, 20)
                    } else { // 스크랩한 경우
                        Image(systemName: "bookmark.fill")
                            .padding(.trailing, 20)
                    }
                } else { // 사용자 본인의 글인 경우
                    Menu(content: {
                            Button(action: {
                                self.editorMode = true
                            }, label: {
                                Label("Modify", systemImage: "pencil")
                            })

                        Button(action: {
                            guard let travelId = viewModel.travel.id else { return }
                            viewModel.deleteMainTravel(travelId: travelId)
                        }, label: {
                            Label("Delete", systemImage: "delete.left")
                        })
                    }, label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .padding(.trailing, 20)
                            .foregroundColor(.black)
                    })
                }
            }
            
            HStack {
                ForEach (1..<4) { idx in
                    CategoryButton(categoryName: "Day" + String(idx))
                        .padding([.leading, .trailing], 10)
                        .padding(.top)
                }
            }
            
            ScrollView {
                ForEach (0..<3) { _ in
                    NavigationLink (destination: DetailTravelView(), label: {
                        VisitedCell()
                            .foregroundColor(.black)
                    })
                }
                
                NavigationLink(destination: CreateDetailTravelView(numberOfPriceInfo: 0, numberOfTipInfo: 0), label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(50)
                })
            }
        }
        .popup(isPresented: $editorMode, view: {
            MainTravelEditorView(editingMode: true)
                .background(Color("lightgray"))
        })
        .onReceive(viewModel.$deleted, perform: { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
            }
        })
    }
}
