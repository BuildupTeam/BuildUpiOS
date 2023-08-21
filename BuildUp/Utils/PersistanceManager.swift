//
//  PersistanceManager.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit

extension PersistenceKeyBase {

    public static let latestViewController = PersistenceKey<String?>(key: "latest_view_controller", defaultValue: nil)
    
    public static let notificationRegisToken = PersistenceKey<String?>(key: "resgis_token", defaultValue: nil)
    
    public static let phoneValidationId = PersistenceKey<String?>(key: "phoneValidationId", defaultValue: nil)

}

open class PersistanceManager {
    
    internal static  var shared: PersistanceManager = {
        let instance = PersistanceManager(userDefaults: .standard)
        return instance
    }()
    
    public let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public class func clearAll() {
        
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            shared.userDefaults.removeVolatileDomain(forName: bundleIdentifier)
            shared.userDefaults.synchronize()
        }
    }
    
    public class func setLatestViewController(_ value: String) {
        shared.setValue(value, forKey: PersistenceKeyBase.latestViewController)
    }
    public class func geLatestViewController() -> String? {
        return shared.valueForKey(PersistenceKeyBase.latestViewController)
    }
    
    public class func setNotificationRegisToken(_ value: String) {
        shared.setValue(value, forKey: PersistenceKeyBase.notificationRegisToken)
    }
    public class func getNotificationRegisToken() -> String? {
        return shared.valueForKey(PersistenceKeyBase.notificationRegisToken)
    }
    
    public class func setPhoneValidationId(_ value: String) {
        shared.setValue(value, forKey: PersistenceKeyBase.phoneValidationId)
    }
    public class func getPhoneValidationId() -> String? {
        return shared.valueForKey(PersistenceKeyBase.phoneValidationId)
    }
}

extension PersistanceManager: KeyValuePersistence {
    
    public func valueForKey<T>(_ key: PersistenceKey<T>) -> T {
        let value = userDefaults.object(forKey: key.key)
        return (value as? T) ?? key.defaultValue
    }
    
    public func setValue<T>(_ value: T?, forKey key: PersistenceKey<T>) {
        guard let value = value else {
            userDefaults.removeObject(forKey: key.key)
            return
        }
        
        if let value = value as? Int {
            userDefaults.set(value, forKey: key.key)
        } else if let value = value as? Float {
            userDefaults.set(value, forKey: key.key)
        } else if let value = value as? Double {
            userDefaults.set(value, forKey: key.key)
        } else if let value = value as? Bool {
            userDefaults.set(value, forKey: key.key)
        } else if let value = value as? URL {
            userDefaults.set(value, forKey: key.key)
        } else if let value = value as? Data {
            userDefaults.set(value, forKey: key.key)
        } else {
            userDefaults.set(value, forKey: key.key)
        }
    }
    
    public func removeValueForKey<T>(_ key: PersistenceKey<T?>) {
        userDefaults.removeObject(forKey: key.key)
    }
}
