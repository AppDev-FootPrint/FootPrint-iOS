//
//  File.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/18.
//

import SwiftUI

// BE 구현 X
class SearchViewModel: ObservableObject {
    @Published var travels = [MainTravel]()
    
    init() {
        fetchHistories()
    }
    
    func fetchHistories() {
    }
    
    func filteredHistories(_ query: String) -> [MainTravel] {
        return travels
    }
}
