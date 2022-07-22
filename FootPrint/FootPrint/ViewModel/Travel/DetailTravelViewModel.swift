//
//  DetailTravelViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/20.
//

import SwiftUI
import Alamofire

class DetailTravelViewModel: ObservableObject {
    
    @Published var created = false
    @Published var deleted = false
    @Published var updated = false
    @Published var detail: DetailTravel
    
    init(detail: DetailTravel) {
        self.detail = detail
    }
    
    // Detail 개별 조회
    func fetchDetail(id: Int, completion: @escaping(_ data: DetailTravel) -> Void) {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/detail-travels/\(id)"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json", "Authorization": String(user.accessToken ?? "no_permission")])
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let travel) : // statueCode == 200 OK
                        let json = travel.data(using: .utf8)!
                        do {
                            let data = try JSONDecoder().decode(DetailTravel.self, from: json)
                            self.detail = DetailTravel(id: id, mainTravelId: data.mainTravelId, title: data.title, review: data.review, tip: data.tip, visitedDate: data.visitedDate, address: data.address, roadAddress: data.roadAddress, mapX: data.mapX, mapY: data.mapY, createPriceRequestList: data.createPriceRequestList, createImageRequestList: data.createImageRequestList)
                            print("✅ DEBUG on fetchDetail() ")
                            
                            completion(self.detail)
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchDetail(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchDetail(): \(response.result)")
            }
        }
    }
    
    func updateDetail(title: String, startDate: String, endDate: String, isVisible: Bool, isCompleted: Bool, mainImagePath: String) {
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
                print("DEBUG on updateDetail() : ✅ success to create main travel")
            } else {
                print("DEBUG on updateDetail() : 🚫 fail to create main travel")
            }
        }
    }
}
