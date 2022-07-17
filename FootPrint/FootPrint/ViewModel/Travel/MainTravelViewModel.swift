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
    @Published var travel: MainTravel
    
    init(travel: MainTravel) {
        self.travel = travel
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
            print("DEBUG on createMainTravel() : \(String(describing: response.response))")
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
    
    func modifyTravel(travelId: Int, title: String, startDate: String, endDate: String, isVisible: Bool, isCompleted: Bool, mainImagePath: String) {
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
