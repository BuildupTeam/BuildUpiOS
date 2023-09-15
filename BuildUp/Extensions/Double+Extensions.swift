//
//  Double+Extensions.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation

extension Double {
    func trimAfter(digit: Int) -> Double? {
        let stringNum = "\(self)"
        if stringNum.count >= digit + 1 {
        let newStringNum = stringNum.subString(from: 0, to: digit)
            return Double(newStringNum)
        } else {
            return self
        }
    }
}
