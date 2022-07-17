//
//  FeedViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI
import Alamofire

class FeedViewModel: ObservableObject {
    @Published var travels = [MainTravel]()
    
    init() {
        fetchTravels()
    }
    
    func fetchTravels() {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/main-travels"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json", "Authorization": String(user.accessToken ?? "no_permission")])
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success :
                        print("✅ DEBUG on fetchTravels(): \(response.result)")
                    case .failure :
                        print("🚫 DEBUG on fetchTravels(): \(response.result)")
            }
        }
    }
}
