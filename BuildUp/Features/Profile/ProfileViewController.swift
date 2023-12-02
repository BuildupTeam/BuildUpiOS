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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
}

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
        self.viewModel.getProfile()
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
}
    

extension ProfileViewController {
    func logoutAction() {
        self.showLoading()
        self.viewModel.logoutUser()
    }
    
    func openEditProfile() {
        
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
}


