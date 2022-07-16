//
//  User.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/06.
//
import SwiftUI

struct User: Identifiable, Codable {
    var id: Int?
    var username: String
    var password: String
    var nickname: String?
    
    var accessToken: String?
    
    var bio: String?
}
