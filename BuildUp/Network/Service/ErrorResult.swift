//
//  ErrorResult.swift
//  flyers
//
//  Created by Mahmoud Nasser on 27/09/2022.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case custom(string: String)
}
