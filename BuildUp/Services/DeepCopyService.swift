//
//  DeepCopyService.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation

class DeepCopyService: NSObject {
    static let shared = DeepCopyService()
    
    static func getSuportedLanguagesCopy(languages: [LanguageModel]) -> [LanguageModel]? {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: languages,
                requiringSecureCoding: false)
            
            do {
                if let languages = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                    encodedData) as? [LanguageModel] {
                    return languages
                }
            }
            
        } catch {
            
        }
        return nil
    }
    
    /*
    static func getCitiesCopy(cities: [CityModel]) -> [CityModel]? {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: cities,
                requiringSecureCoding: false)
            
            do {
                if let cities = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                    encodedData) as? [CityModel] {
                    return cities
                }
            }
            
        } catch {
            
        }
        return nil
    }
     */
}
