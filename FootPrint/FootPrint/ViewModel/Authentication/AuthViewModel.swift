//
//  AuthViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/06.
//

import SwiftUI
import Alamofire
import JWTDecode

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
            print("DEBUG on register() : \(response.response)")
            if response.response?.statusCode == 201 { // Created
                print("DEBUG on register() : ✅ success to register")
            } else {
                print("DEBUG on register() : ❌ fail to register")
            }
        }
    }
    
    func login(username: String, password: String) {
        let url = "\(Storage().SERVER_URL)/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["username": username,
                      "password": password] as Dictionary
        print("DEBUG on login() : \(params)")

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            print("DEBUG on login() : \(response.response)")
            if response.response?.statusCode == 200 { // OK
                guard let accessToken = response.response?.allHeaderFields["Authorization"] else { return }
                
                self.userSession = User(username: username, password: password)
                self.userSession?.accessToken = "\(accessToken)"
                do {
                    let jwt = try decode(jwt: "\(accessToken)")
                    self.userSession?.id = jwt.body["memberId"] as? Int
                } catch {
                    print("catch")
                }
            }
        }
    }
    
    func signout() {
        self.userSession = nil
    }

    func fetchUser() {
        guard let uid = userSession?.id else { return }
        print("DEBUG fetchUser(): uid \(uid)")
    }
}
