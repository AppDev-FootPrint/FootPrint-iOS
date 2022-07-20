//
//  TravelViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI
import Alamofire

class MainTravelViewModel: ObservableObject {
    
    @Published var created = false
    @Published var deleted = false
    @Published var updated = false
    @Published var travel: MainTravel
    
    init(travel: MainTravel) {
        self.travel = travel
    }
    
    func fetchMainTravel(id: Int, completion: @escaping(_ data: MainTravel) -> Void) {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/main-travels/\(id)"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json", "Authorization": String(user.accessToken ?? "no_permission")])
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let travel) : // statueCode == 201 OK
                        let json = travel.data(using: .utf8)!
                        do {
                            let data = try JSONDecoder().decode(MainTravel.self, from: json)
                            self.travel.startDate = data.startDate
                            self.travel.endDate = data.endDate
                            self.travel.isVisible = data.isVisible
                            self.travel.isCompleted = data.isCompleted
                            self.travel.mainImagePath = data.mainImagePath
                            self.travel.createDetailTravelRequest = data.createDetailTravelRequest
                            self.travel.likeNum = data.likeNum
                            self.travel.createdAt = data.createdAt
                            let writer = data.writerInfo
                            self.travel.writerInfo = WriterInfo(id: writer?.id ?? 0, username: writer?.username ?? "", nickname: writer?.nickname ?? "")
                            self.travel.didLike = data.didLike
                            print("✅ DEBUG on fetchMainTravel() \(self.travel)")
                            
                            completion(self.travel)
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchMainTravel(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchMainTravel(): \(response.result)")
            }
        }
    }
    
    func createMainTravel(title: String, startDate: String, endDate: String, isVisible: Bool, isCompleted: Bool, mainImagePath: String) {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/main-travels"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(user.accessToken ?? "no_value")", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["title": title,
                      "startDate": startDate,
                      "endDate": endDate,
                      "isVisible": isVisible,
                      "isCompleted": isCompleted,
                      "mainImagePath": mainImagePath,
                      "createDetailTravelRequest": []] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            if response.response?.statusCode == 201 { // Created
                print("DEBUG on createMainTravel() : ✅ success to create main travel")
                self.created = true
                self.travel = MainTravel(title: title, startDate: startDate, endDate: endDate, isVisible: isVisible, isCompleted: isCompleted, mainImagePath: mainImagePath, createDetailTravelRequest: [], likeNum: 0)
                switch response.result {
                case .success(let id):
                    self.travel.id = Int(id)
                    print("✅ DEBUG createMainTravel(): travel info \(self.travel)")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            } else {
                print("DEBUG on createMainTravel() : 🚫 fail to create main travel")
            }
        }
    }
    
    func modifyTravel(travelId: Int, title: String, startDate: String, endDate: String, isVisible: Bool, isCompleted: Bool, mainImagePath: String, createdAt: String, writerInfo: WriterInfo, didLike: Bool) {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/main-travels/\(travelId)"
        let params: Parameters = ["title": title,
                                  "startDate": startDate,
                                  "endDate": endDate,
                                  "isVisible": isVisible,
                                  "isCompleted": isCompleted,
                                  "mainImagePath": mainImagePath,
                                  "createDetailTravelRequest": []] as Dictionary
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(user.accessToken ?? "no_permission")", forHTTPHeaderField: "Authorization")
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                if response.response?.statusCode == 200 {
                    self.updated = true
                    self.travel = MainTravel(id: travelId, title: title, startDate: startDate, endDate: endDate, isVisible: isVisible, isCompleted: true, mainImagePath: mainImagePath, createDetailTravelRequest: [], likeNum: 1000, commentCount: 0, createdAt: createdAt, writerInfo: writerInfo, didLike: didLike)
                    print("✅ DEBUG on modifyTravel(): \(response.result)")
                } else {
                    print("🚫 DEBUG on modifyTravel(): \(response.result)")
            }
        }
    }
    
    func deleteMainTravel(travelId: Int) {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/main-travels/\(travelId)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(user.accessToken ?? "no_permission")", forHTTPHeaderField: "Authorization")
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                if response.response?.statusCode == 200 {
                    print("✅ DEBUG on deleteMainTravel(): success to delete!\n \(response.result)")
                    self.deleted = true
                } else {
                    print("🚫 DEBUG on deleteMainTravel(): \(response.result)")
            }
        }
    }
}
