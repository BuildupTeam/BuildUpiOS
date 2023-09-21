//
//  AppTabBarViewController.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import UIKit
// swiftlint:disable all

class AppTabBarViewController: UITabBarController {
    
    var previousViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.layer.borderWidth = 0
        self.tabBar.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        self.tabBar.unselectedItemTintColor = ThemeManager.colorPalette?.buttonIconColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonIconColor4 ?? "")
        
        self.tabBar.clipsToBounds = true
        self.view.backgroundColor = .white
        self.tabBar.selectionIndicatorImage = UIImage()
        
        setupTabbarShadow()
        initialize()
    }
    
    private func setupTabbarShadow() {
        let tabGradientView = UIView(frame: self.tabBar.bounds)
        tabGradientView.backgroundColor = .white
        tabGradientView.translatesAutoresizingMaskIntoConstraints = false;
        self.tabBar.addSubview(tabGradientView)
        self.tabBar.sendSubviewToBack(tabGradientView)
        tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabGradientView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabGradientView.layer.shadowRadius = 3
        tabGradientView.layer.shadowColor = UIColor.gray.cgColor
        tabGradientView.layer.shadowOpacity = 0.05
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
    }
    
    func initialize() {
        self.tabBar.barTintColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        
        let homeVC = Coordinator.MainTaps.createHomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icHomeInactive.image,
            selectedImage: Asset.icHomeActive.image)
                
        let categoriesVC = Coordinator.MainTaps.createCategoriesViewController()
        categoriesVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icCategoriesActive.image,
            selectedImage: Asset.icCategoriesInactive.image)
        
        let cartVC = Coordinator.MainTaps.createCartViewController()
        cartVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icCartActive.image,
            selectedImage: Asset.icCartInactive.image)
        
        let profilVC = Coordinator.MainTaps.createProfileViewController()
        profilVC.tabBarItem = UITabBarItem(
                   title: "",
                   image: Asset.icProfileActive.image,
                   selectedImage: Asset.icProfileInactive.image)
        
        let settingsVC = Coordinator.MainTaps.createSettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icSettingsActive.image,
            selectedImage: Asset.icSettingsInactive.image)
        
        var viewControllerList: [UIViewController] = []
        
        viewControllerList = [homeVC, settingsVC, cartVC, categoriesVC, profilVC]
               
        self.setViewControllers(viewControllerList, animated: false)
    }
}

extension AppTabBarViewController: UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if previousViewController == viewController {
            if let navVC = viewController as? UINavigationController,
                let vc = navVC.viewControllers.first as? HomeViewController {
                if vc.isViewLoaded && (vc.view.window != nil) {
                    vc.scrollToFirstRow()
                }
            }
        }
        previousViewController = viewController
    }
}
