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

// "2000-00-00" 형식의 문자열을 "2000년 0월 0일의 00:00:00"의 Date 타입으로 리턴
func String2Date(date: String) -> Date {
    let splitDate = date.split(separator: "-")
    let stringDate = "\(splitDate[0])-\(splitDate[1])-\(splitDate[2]) 00:00:00"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    return dateFormatter.date(from: stringDate) ?? Date()
}
