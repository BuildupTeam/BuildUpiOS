//
//  LauncherViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import UIKit

enum TabBarIndexs: Int {
    case home = 0
    case wallet
    case createAd
    case applications
    case settings
}

class LauncherViewController: NSObject {
        
    static public func showNextViewController() {
        
        switch PersistanceManager.geLatestViewController() {
        case Constant.ControllerName.subdomin:
            showSubdomainScreen(fromViewController: nil)
        case Constant.ControllerName.home:
            showTabBar(fromViewController: nil)
        case Constant.ControllerName.login:
            showLoginView(fromViewController: nil)
        default :
//            showLoginView(fromViewController: nil)
            showSubdomainScreen(fromViewController: nil)
        }
    }
    
    static public func showViewController(viewController: UIViewController, fromViewController: UIViewController?) {
        if let fromViewController = fromViewController {
            fromViewController.navigationController?.pushViewController(viewController, animated: true)
        } else {
            if let appWindow = AppManager.shared.window {
                appWindow.rootViewController = viewController
                appWindow.makeKeyAndVisible()
            }
        }
    }
    
    static func showTabBar(fromViewController: UIViewController?) {
        let tabBarVC = AppTabBarViewController()
        showViewController(viewController: tabBarVC, fromViewController: nil)
    }
    
    static func showHomeScreen(fromViewController: UIViewController?) {
        let viewController = Coordinator.MainTaps.createHomeViewController()
        showViewController(viewController: viewController, fromViewController: nil)
    }
    
    static func showSubdomainScreen(fromViewController: UIViewController?) {
        let viewController = Coordinator.Controllers.createSubdomainViewController()
        showViewController(viewController: viewController, fromViewController: nil)
    }
    
//    static func showTabBar(selectedIndex: Int? = nil) {
//        let tabBarVC = AppTabBarViewController()
//        if let selectedIndex = selectedIndex {
//            tabBarVC.selectedIndex = selectedIndex
//        }
//        showViewController(viewController: tabBarVC, fromViewController: nil)
//    }
    
    static func showLoginView(fromViewController: UIViewController?) {
        let loginVC = Coordinator.Controllers.createLoginViewController()
        showViewController(viewController: loginVC, fromViewController: nil)
    }
    
    static func showWelcomeView(fromViewController: UIViewController?) {
//        let welcomeVC = Coordinator.MainTaps.createWelcomeViewController()
//        showViewController(viewController: welcomeVC, fromViewController: nil)
    }

    static func showOnboardingView(fromViewController: UIViewController?) {
//        let loginVC = Coordinator.Controllers.createOnboardingViewController()
//        showViewController(viewController: loginVC, fromViewController: nil)
    }
    
    static func logoutToLoginView() {
        CachingService.clearUserData()
        CachingService.removeAllCachedData()
        CachingService.setCartProducts(products: [:])
        RealTimeDatabaseService.clearCart()
        showLoginView(fromViewController: nil)
    }
    
    static func logoutToFirstView() {
        CachingService.clearUserData()
        CachingService.removeAllCachedData()
        
//        let loginManager = LoginManager()
//        loginManager.logOut()
//
//        showCountryView(fromViewController: nil)
    }
    
    static func logoutToHomeView() {
//        CachingService.clearUserData()
//        let tabBarVC = AppTabBarViewController()
//        showViewController(viewController: tabBarVC, fromViewController: nil)
    }
}
