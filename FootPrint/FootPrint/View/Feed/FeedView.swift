//
//  FeedView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/11.
//

import SwiftUI
import PopupView

struct FeedView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    @State private var showToast: Bool = true
    
    var body: some View {
        ScrollView {
            ForEach (viewModel.travels) { travel in
                NavigationLink (destination: MainTravelView(viewModel: MainTravelViewModel(travel: travel)), label: {
                    FeedCell(viewModel: FeedCellViewModel(travel: travel))
                        .foregroundColor(.black)
                }).buttonStyle(PlainButtonStyle())
            }
        }
        .popup(isPresented: $showToast, type: .floater(), position: .bottom, autohideIn: 2) {
            Text("\(AuthViewModel.shared.userSession?.username ?? "회원")님 반갑습니다 :)")
                .frame(width: 200, height: 60)
                .foregroundColor(.white)
                .background(Color("blue"))
                .cornerRadius(30.0)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
