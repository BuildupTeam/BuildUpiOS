//
//  HomeViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!

    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistanceManager.setLatestViewController(Constant.ControllerName.home)
        setupView()
        startShimmer()
        setupResponse()
        self.getHomeData()
    }
    
}

// MARK: - SetupUI
extension HomeViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0.0
        }
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func startShimmer() {
        startShimmerOn(tableView: tableView)
    }
}

// MARK: - Requests
extension HomeViewController {
    
    private func getHomeData() {
        self.viewModel.getHomeTemplate()
     }
    
    private func setupResponse() {
        homeResponse()
    }
}

// MARK: - Responses
extension HomeViewController {
    
    private func homeResponse() {
        viewModel.onData = { [weak self] () in
            guard let `self` = self else { return }
            print("Normal Reload")
            self.title = viewModel.viewTitle
            self.hideLoading()
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
}
