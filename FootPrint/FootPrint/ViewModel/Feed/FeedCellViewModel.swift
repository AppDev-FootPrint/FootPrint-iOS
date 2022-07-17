//
//  FeedCellViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    @Published var travel: MainTravel
    
    var likeString: String {
        let label = (travel.likeNum == 1) ? "like" : "likes"
        return "\(travel.likeNum) \(label)"
    }
    
    init(travel: MainTravel) {
        self.travel = travel
        checkIfUserLikedPost()
    }
    
    func like() {
        guard let user = AuthViewModel.shared.userSession else { return }
        guard let travelId = travel.id else { return }
    }
    
    func unlike() {
        
        // 예외처리 : 좋아요가 마이너스일 수는 없음
        guard (travel.likeNum ?? 0 > 0) else { return }
        guard let uid = AuthViewModel.shared.userSession else { return }
        guard let travelId = travel.id else { return }
        
    }
    
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession else { return }
        guard let travelId = travel.id else { return }
    }
}
