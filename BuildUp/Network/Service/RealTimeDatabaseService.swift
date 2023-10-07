//
//  RealTimeDatabaseService.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/09/2023.
//

import Foundation
import FirebaseDatabase
import ObjectMapper

class RealTimeDatabaseService {
    static let shared = RealTimeDatabaseService()
    
    var ref: DatabaseReference? {
        var configuration = Configuration()
        if configuration.environment == .stage {
            return Database.database().reference()
        } else if  configuration.environment == .live {
            return Database.database(url: "https://buildup-dev-4c1cd-default-rtdb.firebaseio.com").reference()
        } else if  configuration.environment == .preLive {
            return Database.database(url: "https://buildup-dev-4c1cd-default-rtdb.firebaseio.com").reference()
        } else {
            return Database.database().reference()
        }
    }
    
    static func observe(child: String, compeltion: @escaping (([Any]) -> Void)) -> DatabaseReference? {
                        
       let refHandle = shared.ref?.child(child).observe(DataEventType.value, with: { (snapshot) in
            
            let itemsDict = snapshot.value as? [String : AnyObject] ?? [:]
            let jsonItems = itemsDict.map { (item) -> AnyObject in
                return item.value
            }
        
        compeltion(jsonItems)
        })
        
        return self.shared.ref
    }
    
    static func observeObject(child: String, compeltion: @escaping ((Any) -> Void)) -> DatabaseReference? {
        let refHandle = shared.ref?.child(child)
        refHandle?.observe(DataEventType.value, with: { (snapshot) in
            
            let objectDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            compeltion(objectDict)
        })
        
        return refHandle
    }
    
    static func setValueFor(child: String) {
        self.shared.ref?.child("users").child("").setValue(["username": ""])
    }
    
    static func removeAllObservers() {
        shared.ref?.removeAllObservers()
    }
}
