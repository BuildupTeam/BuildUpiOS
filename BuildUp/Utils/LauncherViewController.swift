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
        
        showSplashView(fromViewController: nil)
//        switch PersistanceManager.geLatestViewController() {
//        case Constant.ControllerName.home:
//            showTabBar(fromViewController: nil)
//        case Constant.ControllerName.login:
//            showLoginView(fromViewController: nil)
//        default:
//            showSplashView(fromViewController: nil)
//        }
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
    
    static func showCartTabBar(fromViewController: UIViewController?) {
        let tabBarVC = AppTabBarViewController()
        tabBarVC.selectedIndex = 2
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
    
    static func showLoginView(fromViewController: UIViewController?) {
        let loginVC = Coordinator.Controllers.createLoginViewController()
        showViewController(viewController: loginVC, fromViewController: nil)
    }
    
    static func showSplashView(fromViewController: UIViewController?) {
        let splashVC = Coordinator.Controllers.createSplashViewController()
        showViewController(viewController: splashVC, fromViewController: nil)
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
    }
    
    static func logoutToHomeView() {
        
    }
}
