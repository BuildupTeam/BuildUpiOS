//
//  JsonStringService.swift
//  flyers
//
//  Created by Mahmoud Nasser on 27/09/2022.
//

import Foundation

// swiftlint:disable force_unwrapping
class JsonStringService {
    
    static func getJsonStringForDict(dict: [String: Any]) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let decoded = String(data: jsonData ?? Data(), encoding: .utf8)!
        
        return decoded
    }
    
    static func convertToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func convertToArrayOfDictionary(text: String) -> [[String: String]?]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func convertToDictionary(jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func printParametersAsJson(parameters: [String: Any], baseUrl: String, path: String) {
        var json = getJsonStringForDict(dict: parameters)
        json = json.replacingOccurrences(of: "{", with: "{\n")
        json = json.replacingOccurrences(of: "}", with: "\n}")
        json = json.replacingOccurrences(of: ",", with: ",\n")

        print("\n---------Request Params for-----------\n\(baseUrl + path) \n\n\(json)\n\n--*--*--*--*--*-End-*--*--*--*--*--\n\n")
    }
}
