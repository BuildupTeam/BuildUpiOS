//
//  AppManager.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import UIKit

class AppManager: NSObject {
    static let shared = AppManager()
    
    var window: UIWindow?
    
    static func launchApp(_ application: UIApplication) {
        if #available(iOS 13, *) {
        } else {
            initWindow()
        }
    }
    
    static func initWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.shared.window = window
        LauncherViewController.showNextViewController()

    }
    
    @available(iOS 13.0, *)
    static func initSceneWindow(_ windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        
        self.shared.window = window
        LauncherViewController.showNextViewController()
    }
}
