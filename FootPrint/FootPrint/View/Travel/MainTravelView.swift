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
    var travelTitle: String {
        return viewModel.travel.title!
    }
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
                ForEach (0..<3) { idx in
                    CategoryButton(categoryName: "Day" + String(idx))
                        .padding([.leading, .trailing], 10)
                        .padding(.top)
                }
            }
            
            ScrollView {
                ForEach (viewModel.travel.simpleDetailTravelListResponse ?? []) { detail in
                    NavigationLink (destination: DetailTravelView(id: detail.id, mainId: detail.mainTravelId), label: {
                        VisitedCell(detail: detail)
                            .foregroundColor(.black)
                    })
                }
                
                NavigationLink(destination: DetailTravelEditorView(numberOfPriceInfo: 0, numberOfTipInfo: 0), label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(50)
                })
            }
        }
        .popup(isPresented: $editorMode, type: .floater(), position: .bottom, closeOnTap: false, backgroundColor: Color.secondary) {
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.editorMode = false
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    .foregroundColor(.white)
                    .padding([.top, .trailing])
                }
                
                LazyView(MainTravelEditorView(editingMode: $editorMode, viewModel: viewModel))
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 330)
            .background(Color("lightgray"))
            .cornerRadius(30.0)
        }
        .onReceive(viewModel.$deleted, perform: { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
            }
        })
        .onReceive(viewModel.$updated, perform: { completed in
            if completed {
                self.editorMode = false
            }
        })
    }
}
