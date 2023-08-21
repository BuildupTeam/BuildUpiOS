//
//  Float+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import Foundation

extension Float {
    func roundedOneDigit() -> Float {
        let twoDigitNum = self * 10
        var roundedNum = twoDigitNum.rounded()
        roundedNum /= 10
        return roundedNum
    }
    
    func roundedTwoDigit() -> Float {
        let twoDigitNum = self * 100
        var roundedNum = twoDigitNum.rounded()
        roundedNum /= 100
        return roundedNum
    }
}
