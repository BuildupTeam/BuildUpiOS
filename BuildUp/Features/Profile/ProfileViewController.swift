//
//  ProfileViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ProfileViewModel!
    
    init(viewModel: ProfileViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleResponses()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "
    }
}

// MARK: Private Func
extension ProfileViewController {
    private func setupView() {
        registerTableViewCells()
        self.viewModel.userModel = CachingService.getUser()?.customer
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func handleResponses() {
        handleLogoutResponse()
        handleTokenNotExistResponse()
        profileResponse()
    }
    
    private func handleLogoutResponse() {
        self.viewModel.onLogout = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            LauncherViewController.logoutToLoginView()
        }
    }
    
    private func handleTokenNotExistResponse() {
        self.viewModel.onTokenNotExist = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            LauncherViewController.logoutToLoginView()
        }
    }
    
    private func getProfileData() {
        self.viewModel.getProfile()
    }
    
    private func profileResponse() {
        self.viewModel.onProfile = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
    
    private func showLogoutPopup() {
        let logoutVC = LogoutPopupViewController()
        logoutVC.delegate = self
        self.presentPanModal(logoutVC)
    }
}

extension ProfileViewController: LogoutPopupProtocol {
    func logoutButtonClicked() {
        self.showLoading()
        self.viewModel.logoutUser()
    }
}

// MARK: Actions
extension ProfileViewController {
    func logoutAction() {
        if CachingService.getUser() != nil {
            showLogoutPopup()
        } else {
            LauncherViewController.logoutToLoginView()
        }
    }
    
    func openEditProfile() {
        let editProfileVC = Coordinator.Controllers.createEditProfileViewController()
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    func openAddresses() {
        let addressesVC = Coordinator.Controllers.createAddressesViewController()
        self.navigationController?.pushViewController(addressesVC, animated: true)
    }
    
    func openWishList() {
        let wishListVC = Coordinator.Controllers.createWishListViewController()
        self.navigationController?.pushViewController(wishListVC, animated: true)
        
    }
    
    func openSettings() {
        
    }
    
    func openLanguagesBottomSheet() {
        let viewController = Coordinator.Controllers.createLanguageBottomSheetViewController(delegate: self)
        self.presentPanModal(viewController)
    }
}

// MARK: - Language Bottom Sheet Delegate
extension ProfileViewController: LanguageBottomSheetDelegate {
    func languageSelected(languageModel: LanguageModel, languages: [LanguageModel]) {
        LocalizationManager.supportedLanguages = languages
        CachingService.setSuportedLanguages(languages: languages)
        self.changeLanguage(newLanguage: LocalizationManager.selectedLanguage)
    }
}

