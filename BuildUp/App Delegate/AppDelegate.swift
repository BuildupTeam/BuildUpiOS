//
//  AppDelegate.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        if let path = Bundle.main.path(forResource:"GoogleService-Info", ofType:"plist") {
//            if let options = FirebaseOptions(contentsOfFile: path) {
//                FirebaseApp.configure(options: options)
//            }
//          }
        
        let firebaseDefaultOptions = FirebaseOptions(googleAppID: "1:514166398561:ios:a20b0dc23fd38ce95d5420",
                                              gcmSenderID: "514166398561")
        firebaseDefaultOptions.apiKey = "AIzaSyBFsqwGxC1zsFm4HyJG1-30QBJi8AbybSk"
        firebaseDefaultOptions.projectID = "buildupnotifications"
        firebaseDefaultOptions.bundleID = "com.squadio.buildUp"
        
        // Configure an alternative FIRApp.
        FirebaseApp.configure(options: firebaseDefaultOptions)
        
        let firebaseOptions = FirebaseOptions(googleAppID: "1:738116931986:ios:9bbd49842b4a82e366f14b",
                                              gcmSenderID: "738116931986")
        firebaseOptions.apiKey = "AIzaSyBC4KEHlAjoviwzZpeiSRxxGVV81CA0ssk"
        firebaseOptions.projectID = "buildup-dev-4c1cd"
        firebaseOptions.databaseURL = "https://buildup-dev-4c1cd-default-rtdb.firebaseio.com"
        
        // Configure an alternative FIRApp.
        FirebaseApp.configure(name: "Buildup2", options: firebaseOptions)
        
        setupFirebaseRemoteNotifications(application: application)
        AppManager.launchApp(application)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

