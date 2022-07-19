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
        let url = "\(Storage().SERVER_URL)/api/follows/\(uid)/to/\(currentUser.id!)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(currentUser.accessToken ?? "no_value")", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: [], options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
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
        
        let url = "\(Storage().SERVER_URL)/api/follows/\(uid)/to/\(currentUser.id!)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(currentUser.accessToken ?? "no_permission")", forHTTPHeaderField: "Authorization")
        
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
        guard let currentUser = AuthViewModel.shared.userSession else { return }
        
        let requestHeaders: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "Authorization": String(currentUser.accessToken ?? "no_permission")]
        
        var url = "\(Storage().SERVER_URL)/api/members/\(currentUser.id!)/follower"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: requestHeaders)
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let body) : // if response.response.statuscode == 200
                        let json = body.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode([FollowInfo].self, from: json)
                            for singleData in bundleData {
                                if singleData.followerNickname == self.user.nickname {
                                    self.user.isFollowed = true
                                }
                            }
                            print("✅ DEBUG on checkIfUserIsFollowed()")
                        } catch (let e) {
                            print("⚠️ DEBUG on checkIfUserIsFollowed(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on checkIfUserIsFollowed(): \(response.result)")
            }
        }
        
    }
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        guard let currentUser = AuthViewModel.shared.userSession else { return }
        
        var posts: Int = 0
        var followers: Int = 0
        var followings: Int = 0
        
        let requestHeaders: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "Authorization": String(currentUser.accessToken ?? "no_permission")]
        
        var url = "\(Storage().SERVER_URL)/api/members/\(uid)/follower"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: requestHeaders)
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let body) : // if response.response.statuscode == 200
                        let json = body.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode([FollowInfo].self, from: json)
//                            for singleData in bundleData {
//                            }
                            followings = bundleData.count
                            print("✅ DEBUG on fetchUserStats(): \(bundleData.count)")
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchUserStats(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchUserStats(): \(response.result)")
            }
        }
        
        url = "\(Storage().SERVER_URL)/api/members/\(uid)/followee"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: requestHeaders)
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let body) : // if response.response.statuscode == 200
                        let json = body.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode([FollowInfo].self, from: json)
                            followers = bundleData.count
                            print("✅ DEBUG on fetchUserStats(): \(bundleData.count)")
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchUserStats(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchUserStats(): \(response.result)")
            }
        }
        
        // needs refactoring :: 비동기
        // 유저의 포스트 개수 확인
        url = "\(Storage().SERVER_URL)/api/main-travels/"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: requestHeaders)
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let totalTravels) : // if response.response.statuscode == 201
                        let json = totalTravels.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode(travelBundle.self, from: json)
                            
                            // needs refactoring
                            for singleData in bundleData.mainTravelSimpleInfoResponses {
                                if singleData.writerInfo?.id ?? 0 == uid {
                                    posts += 1
                                }
                            }
                            print("✅ DEBUG on fetchUserStats(): \(bundleData.total)")
                            
                            self.user.stats = UserStats(following: followings, posts: posts, followers: followers)
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchUserStats(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchUserStats(): \(response.result)")
            }
        }
    }
}
