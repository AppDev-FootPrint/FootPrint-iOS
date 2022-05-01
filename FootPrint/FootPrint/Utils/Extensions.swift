//
//  Extensions.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import UIKit

extension UIApplication {
    func endEditing() {  // disappear the keyboard
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
