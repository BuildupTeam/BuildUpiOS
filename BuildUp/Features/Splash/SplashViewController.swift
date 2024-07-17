//
//  SplashViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/03/2024.
//

import UIKit

class SplashViewController: BaseViewController {

    var viewModel: SplashViewModel!
    
    init(viewModel: SplashViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationResponse()
        getConfiguration()
    }
    
    private func getConfiguration() {
//        self.showLoading()
        self.viewModel.getHomeTemplate()
    }

    private func configurationResponse() {
        viewModel.onData = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            if CachingService.getUser() != nil {
                PersistanceManager.setLatestViewController(Constant.ControllerName.home)
                LauncherViewController.showTabBar(fromViewController: nil)
            } else {
                PersistanceManager.setLatestViewController(Constant.ControllerName.login)
                LauncherViewController.showLoginView(fromViewController: nil)
            }
            
        }
    }
}
