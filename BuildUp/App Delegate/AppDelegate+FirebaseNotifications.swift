//
//  AppDelegate+FirebaseNotifications.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import Firebase
import NotificationCenter
import ObjectMapper
import UserNotifications
import Moya
import FirebaseMessaging

// MARK: - Setup
extension AppDelegate {
    func setupFirebaseRemoteNotifications(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self

    }
    
    func configureFirebase() {
        
        var configuration = Configuration()
        if let filePath = Bundle.main.path(forResource: configuration.environment.googleServiceInfo, ofType: "plist") {
            
            guard let options = FirebaseOptions(contentsOfFile: filePath) else { return }
            FirebaseApp.configure(options: options)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let fcmToken = fcmToken {
            print("Firebase registration token: \(String(describing: fcmToken))")
            PersistanceManager.setNotificationRegisToken(fcmToken)
            print("fcmToken: \(fcmToken)")
        }
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken

        //        applozicUpdateDeviceToken(deviceToken: deviceToken)
    }
        
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // This method will be called when app received push notifications in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        completionHandler([.sound, .badge, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        
        completionHandler()
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

// MARK: - Redirections
extension AppDelegate {
}
