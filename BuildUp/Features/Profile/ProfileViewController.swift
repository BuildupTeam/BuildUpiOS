//
//  ProfileViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoutButton: UIButton!

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
        handleLogoutResponse()
        handleTokenNotExistResponse()
        setupView()
    }
    
    private func setupView() {
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        logoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        logoutButton.backgroundColor = UIColor.white
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 8
        logoutButton.titleLabel?.text = L10n.Profile.logout
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
}

extension ProfileViewController {
    @IBAction func logoutAction(_ sender: UIButton) {
        self.showLoading()
        self.viewModel.logoutUser()
    }
}


