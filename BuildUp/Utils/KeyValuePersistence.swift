//
//  KeyValuePersistence.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation

public class PersistenceKeyBase {
}

#if DEBUG
private struct Statics {
    static var registeredKeys = Set<String>()
}
#endif

public final class PersistenceKey<Type>: PersistenceKeyBase {
    public let key: String
    public let defaultValue: Type

    public init(key: String, defaultValue: Type) {
        self.key = key
        self.defaultValue = defaultValue

        #if DEBUG
        if Statics.registeredKeys.contains(key) {
            fatalError("PersistenceKey '\(key)' is registered multiple times")
        }
        Statics.registeredKeys.insert(key)
        #endif
    }

    fileprivate init(_ key: String, _ defaultValue: Type) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

public protocol KeyValuePersistence {

    func valueForKey<T>(_ key: PersistenceKey<T>) -> T
    func setValue<T>(_ value: T?, forKey key: PersistenceKey<T>)
    func removeValueForKey<T>(_ key: PersistenceKey<T?>)
}

extension KeyValuePersistence {
    public func serializedValueForKey<T: NSCoding>(_ key: PersistenceKey<T>) -> T {
        let persistenceKey = PersistenceKey<Data?>(key.key, nil)
        guard let data = valueForKey(persistenceKey) else {
            return key.defaultValue
        }
        let object = NSKeyedUnarchiver.unarchiveObject(with: data)
        guard let value = object as? T else {
            fatalError("Cannot unarchive simple persistence data for key '\(key.key)'")
        }
        return value
    }

    public func setSerializedValue<T: NSCoding>(_ value: T?, forKey key: PersistenceKey<T>) {
        let persistenceKey = PersistenceKey<Data?>(key.key, nil)

        var data: Data?
        if let value = value {
            do {
                data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            } catch {

            }
        } else {
            data = nil
        }
        setValue(data, forKey: persistenceKey)
    }
}
