//
//  Coordinator.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit

class Coordinator {
    class AppBase {
        class func baseNavigationController() -> UINavigationController {

//            let backButton = Asset.icArrowLeft.image
            let backButton = UIImage(named: "") //Asset.icBackNew.image

            UINavigationBar.appearance().backIndicatorImage = backButton
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButton
            
            let navigation = UINavigationController()
            navigation.edgesForExtendedLayout = []
            navigation.extendedLayoutIncludesOpaqueBars = false
            navigation.setNavigationBarHidden(false, animated: false)
                      
            navigation.view.backgroundColor = .clear
            
//            navigation.navigationBar.setShadow(
//                shadowRadius: CGFloat(0.5),
//                xOffset: 0,
//                yOffset: 2,
//                color: .black,
//                opacity: 0.07,
//                cornerRadius: CGFloat(3),
//                masksToBounds: false)
            
            navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigation.navigationBar.shadowImage = UIImage()
            navigation.navigationBar.backgroundColor = .clear
            navigation.navigationBar.tintColor = .titlesBlack
            
            let extraHeight: CGFloat = 10
            let bounds = navigation.navigationBar.bounds
            navigation.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + extraHeight)
            
            return navigation
        }
    }
    
    class MainTaps {
        class func createHomeViewController(viewModel: HomeViewModel = HomeViewModel()) -> UIViewController {
            let viewController = HomeViewController(viewModel: viewModel)

            let navigation = Coordinator.AppBase.baseNavigationController()
            navigation.setViewControllers([viewController], animated: true)
            return navigation
        }
        
//        class func createSettingsViewController(viewModel: BaseViewModel = BaseViewModel()) -> UIViewController {
//            let viewController = SettingsViewController(viewModel: viewModel)
//
//            let navigation = Coordinator.AppBase.baseNavigationController()
//            navigation.setViewControllers([viewController], animated: true)
//            return navigation
//        }
        
    }
    
    class Controllers {
        
//        class func createLoginViewController(viewModel: LoginViewModel = LoginViewModel()) -> UIViewController {
//            let loginVC = LoginViewController(viewModel: viewModel)
//
//            let navigation = Coordinator.AppBase.baseNavigationController()
//            navigation.setViewControllers([loginVC], animated: true)
//            return navigation
//        }
    }
}
