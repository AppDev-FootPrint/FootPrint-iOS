//
//  MainTravel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI

struct MainTravel: Decodable {
    var title: String
    var startDate: String
    var endDate: String
    var isVisible: Bool
    var isCompleted: Bool
    var mainImagePath: String // 중복불가
    var createDetailTravelRequest: [DetailTravel]
}
