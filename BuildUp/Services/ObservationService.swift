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
    static var favItemUpdated: [(() -> Void)] = []
    
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
    
    static func observeOnFavorite() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoriteUpdatedAction(_:)),
            name: .favoriteUpdated,
            object: nil)
    }
    
    @objc
    static func cartUpdatedAction(_ notification: Notification) {
        notifyCartObservers()
    }
    
    @objc
    static func favoriteUpdatedAction(_ notification: Notification) {
        notifyFavObservers()
    }
    
    static func notifyCartObservers() {
        for completion in carItemUpdated {
            completion()
        }
    }
    
    static func notifyFavObservers() {
        for completion in favItemUpdated {
            completion()
        }
    }
    
    static func removeAllObservations() {
        NotificationCenter.default.removeObserver(self, name: .cartupdated, object: nil)
        NotificationCenter.default.removeObserver(self, name: .favoriteUpdated, object: nil)
    }
}

