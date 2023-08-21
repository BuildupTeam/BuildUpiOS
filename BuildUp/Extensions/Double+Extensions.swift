//
//  Double+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
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
