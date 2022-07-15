//
//  FootPrintApp.swift
//  FootPrint
//
//  Created by 문다 on 2022/04/27.
//

import SwiftUI

@main
struct FootPrintApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
