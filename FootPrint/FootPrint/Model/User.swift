//
//  User.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/06.
//

struct User: Identifiable, Decodable {
    var id: Int?
    var username: String
    var password: String?
    var nickname: String?
    var stats: UserStats?
    var accessToken: String?
    
    var bio: String?
    var isFollowed: Bool? = false
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.id == id}
}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}

struct FollowInfo: Decodable {
    var followId: Int
    var followerNickname: String
    var followeeNickname: String
}
