//
//  ProfileViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func follow() {
    }
    
    func unfollow() {
    }
    
    // 이 메소드없으면 프로젝트 재실행 시 디폴트로 unfollow 상태의 뷰가 보인다
    func checkIfUserIsFollowed() {
    }
    
    func fetchUserStats() {
    }
}
