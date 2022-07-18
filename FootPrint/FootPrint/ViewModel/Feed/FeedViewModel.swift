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
        fetchAllTravels()
    }
    
    // 전체 여행 글 조회
    func fetchAllTravels() {
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
                    case .success(let totalTravels) :
                        print("✅ DEBUG on fetchAllTravels(): \(totalTravels)")
                        let json = totalTravels.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode(travelBundle.self, from: json)
                                // 배열로 받은 결과데이터 배열에 추가할 수 있도록
                            for singleData in bundleData.mainTravelSimpleInfoResponses {
                                self.travels.append(MainTravel(id: singleData.id, title: singleData.title, mainImagePath: singleData.mainImagePath, likeNum: 1000, createdAt: singleData.createdAt, writerInfo: WriterInfo(id: singleData.writerInfo?.id ?? 1, username: singleData.writerInfo?.username ?? "", nickname: singleData.writerInfo?.nickname ?? "")))
                            }
                            print("✅ DEBUG on fetchAllTravels(): \(bundleData)")
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchAllTravels(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchAllTravels(): \(response.result)")
            }
        }
    }
}
