//
//  Int+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import Foundation

extension Int {
    
     func toString() -> String {
        return String(self)
    }
}

extension Int {
    func formatNumber() -> String {
        let num = abs(self)
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1000...:
            var formatted = num / 1000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(self)"

        default:
            return "\(sign)\(self)"
        }
    }
    
    func reduceScale(to places: Int) -> Int {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * Double(self) // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return Int(originalDecimal)
    }
}
