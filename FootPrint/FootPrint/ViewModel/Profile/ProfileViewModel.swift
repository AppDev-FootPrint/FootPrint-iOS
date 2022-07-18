//
//  ProfileViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI
import Alamofire

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func follow() {
        guard let uid = user.id else { return } // 현재 보고있는 프로필뷰의 대상 유저 (followee)
        guard let currentUser = AuthViewModel.shared.userSession else { return } // 현재 로그인한 유저 정보 (follower)
        
        let url = "\(Storage().SERVER_URL)/api/follows/\(uid)/to/\(String(describing: currentUser.id))"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(user.accessToken ?? "no_value")", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: [], options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            print("DEBUG on follow() : \(String(describing: response.response))")
            if response.response?.statusCode == 201 { // Created
                print("DEBUG on follow() : ✅ success! Now \(String(describing: currentUser.username)) follows \(self.user.username)")
                self.user.isFollowed = true
            } else {
                print("DEBUG on follow() : 🚫 fail to follow")
            }
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return } // 현재 보고있는 프로필뷰의 대상 유저 (followee)
        guard let currentUser = AuthViewModel.shared.userSession else { return } // 현재 로그인한 유저 정보 (follower)
        
        let url = "\(Storage().SERVER_URL)/api/follows/\(uid)/to/\(String(describing: currentUser.id))"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(user.accessToken ?? "no_permission")", forHTTPHeaderField: "Authorization")
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                if response.response?.statusCode == 200 {
                    print("✅ DEBUG on unfollow(): success! \(String(describing: currentUser.username)) unfollows \(self.user.username)")
                    self.user.isFollowed = false
                } else {
                    print("🚫 DEBUG on unfollow(): \(response.result)")
            }
        }
    }
    
    // 이 메소드없으면 프로젝트 재실행 시 디폴트로 unfollow 상태의 뷰가 보인다
    func checkIfUserIsFollowed() {
        guard !user.isCurrentUser else { return } // can't follow oneself
        guard let uid = user.id else { return }
        
        
    }
    
    func fetchUserStats() {
    }
}
