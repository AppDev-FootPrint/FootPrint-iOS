//
//  User.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/06.
//
import SwiftUI

struct User: Identifiable, Codable {
    let id: Int
    var username: String
    var password: String
    var nickname: String
}
