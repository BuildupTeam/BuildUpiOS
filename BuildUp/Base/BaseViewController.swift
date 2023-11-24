//
//  BaseViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import UIKit
import SwiftMessages
import NVActivityIndicatorView
import GoogleMaps
import ObjectMapper
import Windless
//import AVKit
import PopupDialog
import AppsFlyerLib
import Lottie

// swiftlint:disable force_unwrapping
class BaseViewController: UIViewController {
    
//    var baseViewModel: BaseViewModel = BaseViewModel()
    
    private var baseViewModel: BaseViewModel!
    
    // MARK: - init methods
    
    init(viewModel: BaseViewModel = BaseViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.baseViewModel = viewModel
        self.setupBaseResponses()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) var prefersBottomBarHidden: Bool?
    
    final override var hidesBottomBarWhenPushed: Bool {
        get {
            
            let tabbarVC = self.tabBarController as? AppTabBarViewController
            
            if navigationController?.viewControllers.last == self {
                return prefersBottomBarHidden ?? super.hidesBottomBarWhenPushed
            } else {
                return false
            }
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    var address: String?
    var activityIndicatorView: NVActivityIndicatorView?
    var isLoadingShimmer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseResponses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func addFeedbackGenerator() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }
    
    func setupNavigationTitle(title: String, size: CGFloat, weight: FontWeight, tintColor: UIColor, foregroundColor: UIColor ) {
        self.navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.appFont(ofSize: size, weight: weight),  
            NSAttributedString.Key.foregroundColor: foregroundColor]
        self.navigationController?.navigationBar.tintColor = tintColor
    }
    
    func showError(message: String) {
        
        let error = MessageView.viewFromNib(layout: .tabView)
        //        success.configureTheme(.success)
        let iconImage = (IconStyle.default).image(theme: .error)
        error.configureTheme(backgroundColor: .errorBackGround, foregroundColor: .black, iconImage: iconImage)
        error.iconImageView?.tentImageColor(color: .red)
        error.configureDropShadow()
        error.configureContent(title: L10n.Message.Error.title, body: message)
        error.button?.isHidden = true
        error.titleLabel?.isHidden = true
        error.titleLabel?.lineHeight = 0
        error.iconLabel?.lineHeight = 0
        
        error.accessibilityIdentifier = "error_message"
        
        if message.count <= 40 {
            error.layoutMarginAdditions = UIEdgeInsets(top: -8, left: 0, bottom: 10, right: 0)
            error.backgroundHeight = 92
            
        } else {
            error.layoutMarginAdditions = UIEdgeInsets(top: -8, left: 0, bottom: 20, right: 0)
            error.backgroundHeight = 110
        }
        
        var errorConfig = SwiftMessages.defaultConfig
        errorConfig.presentationStyle = .top
        errorConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: errorConfig, view: error)
    }
    
    func showSuccessMessage(message: String) {
        let success = MessageView.viewFromNib(layout: .tabView)
        //        success.configureTheme(.success)
        
        let iconImage = (IconStyle.default).image(theme: .success)
        success.configureTheme(backgroundColor: .sucessBackground, foregroundColor: .black, iconImage: iconImage)
        success.iconImageView?.tentImageColor(color: .sucess)
        success.configureDropShadow()
        success.configureContent(title: L10n.Message.Success.title, body: message)
        success.button?.isHidden = true
        success.titleLabel?.isHidden = true
        success.titleLabel?.lineHeight = 0
        success.iconLabel?.lineHeight = 0
        
        success.accessibilityIdentifier = "success_message"
        
        if message.count <= 40 {
            success.layoutMarginAdditions = UIEdgeInsets(top: -8, left: 0, bottom: 10, right: 0)
            success.backgroundHeight = 92
            
        } else {
            success.layoutMarginAdditions = UIEdgeInsets(top: -8, left: 0, bottom: 20, right: 0)
            success.backgroundHeight = 105
        }
        
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    func addBlueEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.addSubview(blurEffectView)
    }
    
    func openWebView(url: String, pageTitle: String) {
        let webViewVC = WebViewController()
        webViewVC.pageTitle = pageTitle
        webViewVC.webViewUrl = url
        self.navigationController?.present(webViewVC, animated: true)
    }
}

extension BaseViewController {
    func getAddress(lat: Double, lng: Double) {
        var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lng
        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc,
                                   completionHandler: { (placemarks, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            var placeMark: CLPlacemark!
            var userAddress: String?
            placeMark = placemarks?[0]
            if placeMark != nil {
                if placeMark.subThoroughfare != nil {
                    userAddress = (userAddress ?? "") + placeMark.subThoroughfare! + ", "
                }
                if placeMark.thoroughfare != nil {
                    userAddress = (userAddress ?? "") + placeMark.thoroughfare! + ", "
                }
                if placeMark.subLocality != nil {
                    userAddress = (userAddress ?? "") + placeMark.subLocality! + ", "
                }
                if placeMark.locality != nil {
                    userAddress = (userAddress ?? "") + placeMark.locality! + ", "
                }
                if placeMark.administrativeArea != nil {
                    userAddress = (userAddress ?? "") + placeMark.administrativeArea! + ", "
                }
                if placeMark.country != nil {
                    userAddress = (userAddress ?? "") + placeMark.country! + ", "
                }
                
                self.address = userAddress
            }
        })
    }
}

extension BaseViewController {
    
    func changeLanguage(newLanguage: LanguageModel) {
        NotificationCenter.default.post(name: Notification.Name.languageChanged, object: nil, userInfo: nil)
                
        LocalizationManager.changeLanguage(
            language: newLanguage,
            splash: nil ) { () -> UIViewController in
                let tabBarVC = AppTabBarViewController()
                tabBarVC.selectedIndex = TabBarIndexs.settings.rawValue
                return tabBarVC
        }
    }
    
    func changeLanguageAtFirstLaunch(newLanguage: LanguageModel) {
        NotificationCenter.default.post(name: Notification.Name.languageChanged, object: nil, userInfo: nil)
        
//        LocalizationManager.changeLanguage(
//            language: newLanguage,
//            splash: nil ) { () -> UIViewController in
//                Coordinator.Controllers.createOnboardingViewController()
//        }
    }
}

// MARK: - Shimmer
extension BaseViewController {
    func startShimmerOn(tableView: UITableView) {
        tableView.scrollToTopRow()
        isLoadingShimmer = true
        tableView.separatorStyle = .none
//        tableView.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            tableView.windless.apply {
                $0.animationBackgroundColor = .windlessAnimationBackgroundColor
                $0.animationLayerColor = .windlessAnimationLayerColor
                $0.duration = 1.5
                $0.pauseDuration = 1
                $0.direction = .rightDiagonal
            }.start()
        }
    }
    
    func stopShimmerOn(tableView: UITableView) {
        isLoadingShimmer = false
        tableView.windless.end()
//        tableView.isUserInteractionEnabled = true

    }
    
    func startShimmerOn(collectionView: UICollectionView) {
        isLoadingShimmer = true
//        collectionView.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            collectionView.windless.apply {
                $0.animationBackgroundColor = .windlessAnimationBackgroundColor
                $0.animationLayerColor = .windlessAnimationLayerColor
                $0.duration = 1.5
                $0.pauseDuration = 1
                $0.direction = .rightDiagonal
            }.start()
        }
    }
    
    func stopShimmerOn(collectionView: UICollectionView) {
        isLoadingShimmer = false
        collectionView.windless.end()
//        collectionView.isUserInteractionEnabled = true
    }
}

// MARK: - Firebase
extension BaseViewController {
     
}

// MARK: - Base Responses
extension BaseViewController {
    
    private func setupBaseResponses() {
        networkErrorResponse()
        businessErrorResponse()
        authenticationErrorResponse()
        forceUpdate()
    }
    
    private func networkErrorResponse() {
        baseViewModel.onNetworkError = { [weak self] (error) in
            guard let `self` = self else { return }
            
            if error?.code == 6 {
                self.hideLoading()
                self.showError(message: L10n.NetworkError.noInternet)
            }
            
            if (error?.statusCode ?? 0) >= 50 {
                self.hideLoading()
                self.showError(message: L10n.NetworkError.serverError)
            }
        }
    }
    
    private func businessErrorResponse() {
        baseViewModel.onBusinessError = { [weak self] (errorMessage) in
            guard let `self` = self else { return }
            self.hideLoading()
            self.showError(message: errorMessage ?? "")
        }
    }
    
    private func authenticationErrorResponse() {
        baseViewModel.onAuthenticationError = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            LauncherViewController.logoutToLoginView()
        }
    }
    
    private func forceUpdate() {
        baseViewModel.onForceUpdate = { [weak self] (_) in
            guard let `self` = self else { return }
            self.hideLoading()
            self.showForceToUpdateAlert()
        }
    }
}

// MARK: - Force Update
extension BaseViewController {
    func showForceToUpdateAlert() {
        self.hideLoading()
        let alert = UIAlertController(title: L10n.ForceUpdate.title,
                                      message: L10n.ForceUpdate.message,
                                      preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: L10n.ForceUpdate.UpdateACtion.title,
                                         style: UIAlertAction.Style.default) { _ in
            
//            var url  = URL(string: "itms-apps://itunes.apple.com/app/bars/id1506598270?mt=8")
            
            if let url = URL(string: "itms-apps://itunes.apple.com/app/bars/1658767231") {
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            
        }
        
        alert.addAction(updateAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension BaseViewController {
    func showLoading(withDelay: Bool = false) {
        CustomLoadingIndicator.manager.show(withDelay: withDelay)
    }
    
    func hideLoading() {
        CustomLoadingIndicator.manager.dismiss()
    }
}

// MARK: - Side Menu
extension BaseViewController {
//    func openSideMenu(from centerViewController: String) {
//        
//        if LocalizationManager.isRTLdirection() {
//            (panel?.right as? SideMenuViewController)?.centerViewController = centerViewController
//            panel?.openRight(animated: true)
//
//        } else {
//            (panel?.left as? SideMenuViewController)?.centerViewController = centerViewController
//            panel?.openLeft(animated: true)
//        }
//    }
}

//// MARK: - AppsFlyer One Link Generator
//extension BaseViewController {
//    func generateOneLink(completionHandler: @escaping ((URL?) -> Void)) {
//        
//        AppsFlyerShareInviteHelper.generateInviteUrl { generator in
//            generator.addParameterValue(CachingService.getUser()?.userIdentifier ?? "", forKey: "deep_link_sub2")
//            generator.addParameterValue("main", forKey: "deep_link_value")
//            
//            generator.setCampaign("referral_link")
//            return generator
//            
//        } completionHandler: { url in
//            if url != nil {
//                completionHandler(url)
//            }
//        }
//
//    }
//}
