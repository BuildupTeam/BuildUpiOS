//
//  Array+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import Foundation

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}


extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

extension Array where Element == String.SubSequence {
    func toStringArray() -> [String] {
        var stringArray: [String] = []
        
        for element in self {
            stringArray.append(String(element))
        }
        
        return stringArray
    }
}

extension Array where Element == Int {
    
    func intToStringArray() -> [String] {
        var stringArray: [String] = []
        
        for element in self {
            stringArray.append(String(element))
        }
        
        return stringArray
    }
    
    func toString() -> String {
        let array = self.intToStringArray()
        var stringArray = ""
        
        for (index, element) in array.enumerated() {
            stringArray += element
            
            if index < (array.count - 1) {
                stringArray += ","
            }
        }
        
        return stringArray
    }
}
