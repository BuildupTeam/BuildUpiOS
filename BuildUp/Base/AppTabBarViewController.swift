//
//  AppTabBarViewController.swift
//  flyers
//
//  Created by Mahmoud Nasser on 01/03/2023.
//

import Foundation
import UIKit
// swiftlint:disable all

class AppTabBarViewController: UITabBarController {
    
    public var didTapButtonFromHome: (() -> ())?
    public var didTapButtonFromWallet: (() -> ())?
    public var didTapButtonFromApplications: (() -> ())?
    public var didTapButtonFromSettings: (() -> ())?

    var holderView = UIView()
    var middleButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
        
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.layer.borderWidth = 0
        self.tabBar.tintColor = .primaryColor
//        self.tabBar.unselectedItemTintColor = .backgroundLightGray2
        //
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.appFont(ofSize: 13, weight: .regular)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.appFont(ofSize: 13, weight: .regular)], for: .selected)
        
        self.tabBar.clipsToBounds = false
        self.tabBar.layer.masksToBounds = false
        self.view.backgroundColor = .white
//        self.tabBar.selectionIndicatorImage = UIImage()

        setupTabbarShadow()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bringMiddleButtonViewToFront()
    }
    
    public func bringMiddleButtonViewToFront() {
        self.view.bringSubviewToFront(middleButton!)
        self.view.layoutIfNeeded()
    }
    
    private func setupMiddleButton() {
        let holderSize: CGFloat = 100
        let cardSize: CGFloat = 68
        let buttonsize: CGFloat = 44
    
      
        holderView = UIView(frame: CGRect(
           x: (self.view.bounds.width / 2) - (holderSize / 2),
           y: -30 ,
           width: holderSize,
           height: holderSize))
        
        holderView.backgroundColor = .clear
        
        let cardView = UIView(frame: CGRect(
            x: (holderSize - cardSize) / 2,
            y: (holderSize - cardSize) / 2,
            width: cardSize,
            height: cardSize))
        
        cardView.backgroundColor = .backgroundLightGray
        cardView.layer.cornerRadius = cardSize / 2
        
        holderView.addSubview(cardView)
        holderView.bringSubviewToFront(cardView)
        
        let imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: holderView.bounds.width,
            height: holderView.bounds.height))
//        imageView.image = Asset.icTabbarPlus.image
        
        holderView.addSubview(imageView)
        holderView.bringSubviewToFront(imageView)
        
        middleButton = UIButton(frame: CGRect(
            x: (self.view.bounds.width / 2) - (buttonsize / 2),
            y: (self.tabBar.frame.minY) - 37 ,
            width: buttonsize,
            height: buttonsize))
        middleButton?.backgroundColor = .clear
        
        middleButton?.addTarget(self, action: #selector(self.middleButtonAction), for: .touchUpInside)
        
        
        self.tabBar.addSubview(holderView)
        self.tabBar.bringSubviewToFront(holderView)
        self.tabBar.layoutIfNeeded()
        
        
        self.view.addSubview(middleButton!)
        self.view.bringSubviewToFront(middleButton!)
        self.view.layoutIfNeeded()
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
        tabGradientView.layer.shadowOpacity = 0.2
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
    }

    func initialize() {
        self.tabBar.barTintColor = .white

        /*
        let homeVC = Coordinator.MainTaps.createHomeViewController()

        homeVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.home,
            image: Asset.icHomeInactive.image,
            selectedImage: Asset.icHomeActive.image)

        let walletVC = Coordinator.MainTaps.createWalletViewController()
        walletVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.wallet,
            image: Asset.icWalletInactive.image,
            selectedImage: Asset.icWalletActive.image)

        let createAdVC = Coordinator.Controllers.createCraeteAdStep1ViewController()

        createAdVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)

        let applicationsVC = Coordinator.MainTaps.createApplicationsViewController()
        applicationsVC.tabBarItem = UITabBarItem(
                   title: L10n.Tabbar.applications,
                   image: Asset.icApplicationsInactive.image,
                   selectedImage: Asset.icApplicationsActive.image)

        let settingsVC = Coordinator.MainTaps.createSettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(
            title: L10n.Tabbar.settings,
            image: Asset.icSettingsInactive.image,
            selectedImage: Asset.icSettingsActive.image)

        var viewControllerList: [UIViewController] = []

        viewControllerList = [homeVC, walletVC, createAdVC, applicationsVC, settingsVC]

        self.setViewControllers(viewControllerList, animated: false)
         */
    }

//    func routeToCreateNewAd() {
//        AppAnalyticsService.createAdEvent()
//        let viewController = Coordinator.Controllers.createCraeteAdStep1ViewController()
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
    
    @objc func middleButtonAction(sender: UIButton) {
        notifyObservers()
    }
    
    func notifyObservers() {
        
        switch selectedIndex {
        case TabBarIndexs.home.rawValue:
            didTapButtonFromHome?()
        case TabBarIndexs.wallet.rawValue:
            didTapButtonFromWallet?()
        case TabBarIndexs.applications.rawValue:
            didTapButtonFromApplications?()
        case TabBarIndexs.settings.rawValue:
            didTapButtonFromSettings?()
        default:
            LauncherViewController.showTabBar(selectedIndex: TabBarIndexs.home.rawValue)
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
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
                return true
            }

        if selectedIndex == TabBarIndexs.createAd.rawValue {
                return false
            }

            return true
        }
}
