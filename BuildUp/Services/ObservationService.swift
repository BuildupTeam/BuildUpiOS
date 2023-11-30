//
//  ObservationService.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation

class ObservationService {
    static let shared = ObservationService()
    
    static var carItemUpdated: [(() -> Void)] = []
    
    
}

// MARK: - Firebase & Observation Handler
extension ObservationService {
    static func observeOnCart() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cartUpdatedAction(_:)),
            name: .cartupdated,
            object: nil)
    }
    
    @objc
    static func cartUpdatedAction(_ notification: Notification) {
        notifyObservers()
//        removeCartObservations()
    }
    
    static func notifyObservers() {
        for completion in carItemUpdated {
            completion()
        }
    }
    
    static func removeCartObservations() {
        NotificationCenter.default.removeObserver(self, name: .cartupdated, object: nil)
    }
}

