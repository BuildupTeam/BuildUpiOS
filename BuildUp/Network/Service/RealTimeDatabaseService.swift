//
//  RealTimeDatabaseService.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/09/2023.
//

import Foundation
import FirebaseAuth
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
    
    static func loginUser(token: String, compeltion: @escaping ((Any) -> Void)) {
        Auth.auth().signIn(withCustomToken: token) { auth, error in
            if error != nil {
                let err = error?.localizedDescription
                print(err!)
            } else {
                if let user = auth?.user {
                    compeltion(user)
                    print(auth?.user)
                }
                //with the uid, we now lookup their user type from the
                //users node, which tells the app if they are a client
                //or worker
            }
        }
//        
//        
//        Auth.auth().signIn(withEmail: "paul@harddaysnight.com", password: "dog",
//             completion: { (auth, error) in
//
//                if error != nil {
//                    let err = error?.localizedDescription
//                    print(err!)
//                } else {
//                    print(auth?.user)
//                    //with the uid, we now lookup their user type from the
//                    //users node, which tells the app if they are a client
//                    //or worker
//                }
//            })
    }
    
    static func setProductModel(model: FirebaseProductModel) {
        let firebaseUserIdchild = Auth.auth().currentUser?.uid ?? ""
        let customerIdchild = CachingService.getUser()?.customer?.uuid ?? ""
        
//        let refHandle = shared.ref?.child(firebaseUserIdchild).child(customerIdchild).set
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
