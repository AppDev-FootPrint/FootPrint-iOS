//
//  FeedGridViewModel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/18.
//

import SwiftUI
import Alamofire

// parameter를 가지는 enum
enum FeedGridConfiguration {
    case explore // 검색창에서는 모든 피드를 조회
    case profile(Int) // 프로필에서는 해당하는 유저의 피드만 조회
}

class FeedGridViewModel: ObservableObject {
    @Published var travels = [MainTravel]()
    let config: FeedGridConfiguration
    
    init(config: FeedGridConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: FeedGridConfiguration) {
        switch config {
        case .explore:
            fetchExplorPageTravels()
        case .profile(let uid):
            fetchUserTravels(uid: uid)
        }
    }
    
    func fetchExplorPageTravels() {
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
                        print("✅ DEBUG on fetchTravels(): \(totalTravels)")
                        let json = totalTravels.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode(travelBundle.self, from: json)
                                // 배열로 받은 결과데이터 배열에 추가할 수 있도록
                            for singleData in bundleData.mainTravelSimpleInfoResponses {
                                self.travels.append(MainTravel(id: singleData.id, title: singleData.title, mainImagePath: singleData.mainImagePath, likeNum: 1000, createdAt: singleData.createdAt, writerInfo: WriterInfo(id: singleData.writerInfo?.id ?? 1, username: singleData.writerInfo?.username ?? "", nickname: singleData.writerInfo?.nickname ?? "")))
                            }
                            print("✅ DEBUG on fetchTravels(): \(bundleData)")
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchTravels(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchTravels(): \(response.result)")
            }
        }
    }
    
    // uid에 맞는 피드만 fetch
    func fetchUserTravels(uid : Int) {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        let url = "\(Storage().SERVER_URL)/api/main-travels/"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json", "Authorization": String(user.accessToken ?? "no_permission")])
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    print("fetchUserTravels: \(response.response?.statusCode)")
                    switch response.result {
                    case .success(let totalTravels) : // if response.response.statuscode == 201
                        print("✅ DEBUG on fetchUserTravels(): \(totalTravels)")
                        let json = totalTravels.data(using: .utf8)!
                        do {
                            let bundleData = try JSONDecoder().decode(travelBundle.self, from: json)
                                // 배열로 받은 결과데이터 배열에 추가할 수 있도록
                            for singleData in bundleData.mainTravelSimpleInfoResponses {
                                if singleData.writerInfo?.id ?? 0 == uid {
                                    self.travels.append(MainTravel(id: singleData.id, title: singleData.title, mainImagePath: singleData.mainImagePath, likeNum: 1000, createdAt: singleData.createdAt, writerInfo: WriterInfo(id: singleData.writerInfo?.id ?? 1, username: singleData.writerInfo?.username ?? "", nickname: singleData.writerInfo?.nickname ?? "")))
                                }
                            }
                            print("✅ DEBUG on fetchUserTravels(): \(bundleData)")
                        } catch (let e) {
                            print("⚠️ DEBUG on fetchUserTravels(): \(e)")
                        }
                    case .failure :
                        print("🚫 DEBUG on fetchUserTravels(): \(response.result)")
            }
        }
    }
}
