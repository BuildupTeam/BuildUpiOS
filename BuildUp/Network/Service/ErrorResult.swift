//
//  ErrorResult.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case custom(string: String)
}
