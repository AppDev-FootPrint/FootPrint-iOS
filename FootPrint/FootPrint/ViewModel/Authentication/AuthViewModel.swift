//
//  AuthViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/06.
//

import SwiftUI
import Alamofire

class AuthViewModel: ObservableObject {
    
    @Published var userSession: User?
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = self.currentUser
        fetchUser()
    }
    
    func register(username: String, password: String, nickname: String) {
        let url = "\(Storage().SERVER_URL)/signUp"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["username": username,
                      "password": password,
                      "nickname": nickname] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success (let userInfo):
                let json = userInfo.data(using: .utf8)!
                do {
                    let user = try JSONDecoder().decode(User.self, from: json)
                    
                    print("✅ DEBUG: \(user.username) \(user.nickname)")
                    self.userSession = User(username: user.username, password: user.password, nickname: user.nickname)
                    self.fetchUser()
                } catch (let error ) {
                    print("🚫 DEBUG: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    func login(username: String, password: String, nickname: String) {
        let url = "\(Storage().SERVER_URL)/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["username": username,
                      "password": password,
                      "nickname": nickname] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success (let userInfo):
                let json = userInfo.data(using: .utf8)!
                do {
                    let user = try JSONDecoder().decode(User.self, from: json)
                    
                    print("✅ DEBUG: \(user.username) \(user.nickname)")
                    self.userSession = User(username: user.username, password: user.password, nickname: user.nickname)
                    self.fetchUser()
                } catch (let error ) {
                    print("🚫 DEBUG: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    func signout() {
        self.userSession = nil
    }

    func fetchUser() {
//        guard let uid = userSession?.id else { return }
//        print("DEBUG: uid \(uid)")
    }
}
