//
//  DateConverter.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/17.
//

import Foundation

struct DateConverter {
    let todayDate : String = Date2String(date: Date())
}

// Date 타입에서 "2000-01-01" 형식의 문자열로 리턴
func Date2String(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    let splitOnlyDate = dateFormatter.string(from: date).split(separator: " ")
    
    return "\(splitOnlyDate[0])"
}
