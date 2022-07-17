//
//  TravelViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI
import Alamofire

class UploadTravelViewModel: ObservableObject {
    
    @Published var created = false
    
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

        print(params)
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
            } else {
                print("DEBUG on createMainTravel() : 🚫 fail to create main travel")
            }
        }
    }
}
