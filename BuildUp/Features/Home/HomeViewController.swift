//
//  HomeViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
        setupResponse()
        self.getHomeData()
        
        startShimmerOn(tableView: tableView)
    }

}

// MARK: - SetupUI
extension HomeViewController {
    private func setupView() {
        registerTableViewCells()
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
            self.hideLoading()
//            self.tableView.refreshControl?.endRefreshing()
//            self.isLoadingShimmer = false
//            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
}
