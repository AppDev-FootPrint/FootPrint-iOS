//
//  DetailTravel.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import SwiftUI

struct DetailTravel: Decodable {
    var title: String
    var review: String
    var tip: String
    var visitedDate: String
    var address: String
    var roadAddress: String
    var mapX: Int
    var mapY: Int
    var createPriceRequestList: [PriceRequest]
    var createImageRequestList: [ImageRequest]
}

struct PriceRequest: Decodable {
    var item: String
    var priceInfo: Int
}

struct ImageRequest: Decodable {
    var path: String
}
