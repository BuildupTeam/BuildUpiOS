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
            return Database.database().reference()
            // Database.database(url: "https://buildup-dev-4c1cd-default-rtdb.firebaseio.com").reference()
        } else if  configuration.environment == .preLive {
            return Database.database().reference()
            //Database.database(url: "https://buildup-dev-4c1cd-default-rtdb.firebaseio.com").reference()
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
                }
            }
        }
    }
    
    static func addUserToFirebase() {
        let firebaseUserIdChild = Auth.auth().currentUser?.uid ?? ""
        let customerIdChild = CachingService.getUser()?.customer?.uuid ?? ""

        checkFirebaseUserAvailability(child: firebaseUserIdChild,completion: { isAvailable in
            if isAvailable {
                shared.ref?.child(firebaseUserIdChild).child(customerIdChild).child("cart").setValue("")
            }
        })
    }
    
    static func checkFirebaseUserAvailability(child: String, completion: @escaping (_ available: Bool)->()) {
        guard let currentUser = Auth.auth().currentUser else { completion(false); return }
        let ref = RealTimeDatabaseService.shared.ref?.child(child)
        
        ref?.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                completion(false)
                return
            } else {
                completion(true)
            }
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

//MARK: - Cart
extension RealTimeDatabaseService {
    static func getProductNode(productUUID: String) -> DatabaseReference? {
        return getCartNode()?.child(productUUID)
    }

    static func getCartNode() -> DatabaseReference? {
       return shared.ref?.child(Auth.auth().currentUser?.uid ?? "").child(CachingService.getUser()?.customer?.uuid ?? "").child("cart")
    }
    
    static func addProductModel(model: FirebaseProductModel) {
        getCartNode()?.child(model.uuid ?? "").updateChildValues(model.dict)
    }
    
    static func addProductModelFromCart(model: FirebaseProductModel) {
        getCartNode()?.child(model.uuid ?? "").setValue(model.dict)
    }
    
    static func removeProductModelFromCart(model: FirebaseProductModel) {
        let combinationString = (model.dict.compactMap({ (key, value) -> String in
            return "\(key)"
        }) as Array).joined(separator: ",")
        
        getCartNode()?.child(model.uuid ?? "").child(combinationString).removeValue()
    }
    
    static func clearCart() {
        getCartNode()?.removeValue()
    }
    
    static func getCartProducts(compeltion: @escaping (([String: [String: Int]]) -> Void)) {
        let prntRef = getCartNode()
        prntRef?.observe(DataEventType.value, with: { (snap) in
            if let fullDic = snap.value as? [String: [String: Int]] {
                CachingService.setCartProducts(products: fullDic)
                compeltion(fullDic)
            } else {
                print("No favourites")
            }
        })
    }
}

//MARK: - Favorites
extension RealTimeDatabaseService {
    static func getFavoriteNode() -> DatabaseReference? {
       return shared.ref?.child(Auth.auth().currentUser?.uid ?? "").child(CachingService.getUser()?.customer?.uuid ?? "").child("favorites")
    }
    
    static func favoriteProductModel(model: FirebaseFavoriteModel) {
        getFavoriteNode()?.child(model.uuid ?? "").updateChildValues(model.dict)
    }
    
    static func unfavoriteProductModel(model: FirebaseFavoriteModel) {
        getFavoriteNode()?.child(model.uuid ?? "").removeValue()
    }
    
    static func favoriteUnfavoriteProduct(model: FirebaseFavoriteModel) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let ref = getFavoriteNode()?.child(model.uuid ?? "")
        
        ref?.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                self.unfavoriteProductModel(model: model)
            } else {
                self.favoriteProductModel(model: model)
            }
        }
    }
    
    // static func observeRunningOrders(child: String, compeltion: @escaping (([Int]) -> Void))
    
    static func getFavoriteList(compeltion: @escaping (([String]) -> Void)) {
        let prntRef = getFavoriteNode()
        prntRef?.observeSingleEvent(of: .value, with: {(snap) in
            if let favDict = snap.value as? [String: AnyObject] {
                let favoriteList = favDict.map { String($0.key) }
                compeltion(favoriteList)
            } else {
                print("No favourites")
            }
       })
    }
}
