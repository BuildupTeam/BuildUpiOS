//
//  AppTabBarViewController.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import UIKit
// swiftlint:disable all

enum TabbarDesign: String {
    case tabbar1 = "tab-bar-1"
    case tabbar2 = "tab-bar-2"
    case tabbar3 = "tab-bar-3"
}

class AppTabBarViewController: UITabBarController {
    
    var previousViewController: UIViewController?
    
    var tabbarSettings: SettingsConfigurationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCachedData()

        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.layer.borderWidth = 0
//        self.tabBar.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
//        self.tabBar.unselectedItemTintColor = ThemeManager.colorPalette?.buttonIconColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonIconColor4 ?? "")
        
        self.tabBar.clipsToBounds = true
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "") //.white
        self.tabBar.selectionIndicatorImage = UIImage()
//        self.tabBar.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -2.0) })
        
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
        self.tabBar.barTintColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        switch tabbarSettings?.tabbarDesign {
        case TabbarDesign.tabbar1.rawValue:
            self.setupTabbar1()
        case TabbarDesign.tabbar2.rawValue:
            self.setupTabbar2()
        case TabbarDesign.tabbar3.rawValue:
            self.setupTabbar3()
        default:
            self.setupTabbar1()
        }
        
        if let activeColorCombination = tabbarSettings?.colorsCombination?.first {
            switch activeColorCombination {
            case "tab_bar_active_1":
                self.tabBar.tintColor = ThemeManager.colorPalette?.tabBarActive1?.toUIColor(hexa: ThemeManager.colorPalette?.tabBarActive1 ?? "")
                self.tabBar.unselectedItemTintColor = ThemeManager.colorPalette?.tabBarInactive1?.toUIColor(hexa: ThemeManager.colorPalette?.tabBarInactive1 ?? "")
            case "tab_bar_active_2":
                self.tabBar.tintColor = ThemeManager.colorPalette?.tabBarActive2?.toUIColor(hexa: ThemeManager.colorPalette?.tabBarActive2 ?? "")
                self.tabBar.unselectedItemTintColor = ThemeManager.colorPalette?.tabBarInactive2?.toUIColor(hexa: ThemeManager.colorPalette?.tabBarInactive2 ?? "")
            case "tab_bar_active_3":
                self.tabBar.tintColor = ThemeManager.colorPalette?.tabBarActive3?.toUIColor(hexa: ThemeManager.colorPalette?.tabBarActive3 ?? "")
                self.tabBar.unselectedItemTintColor = ThemeManager.colorPalette?.tabBarInactive3?.toUIColor(hexa: ThemeManager.colorPalette?.tabBarInactive3 ?? "")
            default:
                self.tabBar.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
                self.tabBar.unselectedItemTintColor = ThemeManager.colorPalette?.buttonIconColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonIconColor4 ?? "")
            }
        }
    }
    
    private func setupTabbar1() {
        let homeVC = Coordinator.MainTaps.createHomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.home,
            image: Asset.icTabbar1HomeActive.image,
            selectedImage: Asset.icTabbar1HomeInactive.image)
                
        let categoriesVC = Coordinator.MainTaps.createCategoriesViewController()
        categoriesVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.categories,
            image: Asset.icTabbar1CategoriesActive.image,
            selectedImage: Asset.icTabbar1CategoriesInactive.image)
        
        let cartVC = Coordinator.MainTaps.createCartViewController()
        cartVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.cart,
            image: Asset.icTabbar1CartActive.image,
            selectedImage: Asset.icTabbar1CartInactive.image)
        
        let profilVC = Coordinator.MainTaps.createProfileViewController()
        profilVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.profile,
                   image: Asset.icTabbar1ProfileActive.image,
                   selectedImage: Asset.icTabbar1ProfileInactive.image)
        
        let ordersVC = Coordinator.MainTaps.createOrderHistoryViewController()
        ordersVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.orders,
            image: Asset.icTabbar1OrdersActive.image,
            selectedImage: Asset.icTabbar1OrdersInactive.image)
        
        var viewControllerList: [UIViewController] = []
        viewControllerList = [homeVC, categoriesVC, cartVC, ordersVC, profilVC]
        self.setViewControllers(viewControllerList, animated: false)
    }
    
    private func setupTabbar2() {
        let homeVC = Coordinator.MainTaps.createHomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icHomeActive.image,
            selectedImage: Asset.icHomeInactive.image)
                
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
        
        let ordersVC = Coordinator.MainTaps.createOrderHistoryViewController()
        ordersVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icOrderHistoryActive.image,
            selectedImage: Asset.icOrderHistoryInactive.image)
        
        var viewControllerList: [UIViewController] = []
        viewControllerList = [homeVC, categoriesVC, cartVC, ordersVC, profilVC]
        self.setViewControllers(viewControllerList, animated: false)
    }
    
    private func setupTabbar3() {
        let homeVC = Coordinator.MainTaps.createHomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.home,
            image: Asset.icTabbar3HomeActive.image,
            selectedImage: Asset.icTabbar3HomeInactive
                .image)
                
        let categoriesVC = Coordinator.MainTaps.createCategoriesViewController()
        categoriesVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.categories,
            image: Asset.icTabbar3CategoriesActive.image,
            selectedImage: Asset.icTabbar3CategoriesInactive.image)
        
        let cartVC = Coordinator.MainTaps.createCartViewController()
        cartVC.tabBarItem = UITabBarItem(
            title: "",
            image: Asset.icTabbar3Cart.image,
            selectedImage: Asset.icTabbar3Cart.image)
        
        let profilVC = Coordinator.MainTaps.createProfileViewController()
        profilVC.tabBarItem = UITabBarItem(
                   title: L10n.Tabbar.profile,
                   image: Asset.icTabbar3ProfileActive.image,
                   selectedImage: Asset.icTabbar3ProfileInactive.image)
        
        let ordersVC = Coordinator.MainTaps.createOrderHistoryViewController()
        ordersVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.orders,
            image: Asset.icTabbar3OrdersActive.image,
            selectedImage: Asset.icTabbar3OrdersInactive.image)
        
        var viewControllerList: [UIViewController] = []
        viewControllerList = [homeVC, categoriesVC, cartVC, ordersVC, profilVC]
        self.setViewControllers(viewControllerList, animated: false)
    }
    
    func getCachedData() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.tabBar.rawValue})?.settings {
            self.tabbarSettings = settings
        }
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
