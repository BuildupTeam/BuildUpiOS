//
//  ProductListViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import UIKit

class ProductsListViewController: BaseViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    var componentModel: ComponentConfigurationModel?
    
    override  var prefersBottomBarHidden: Bool? { return true }

    // MARK: - Private Variables
    
    var viewModel: ProductListViewModel!
//    var homeSectionModel: HomeSectionModel?
    
    init(viewModel: ProductListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResponse()
        getProducts()
        setupView()
        startShimmerOn(tableView: tableView)
    }
}

// MARK: - Private Functions
extension ProductsListViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        let footerView = UIView()
        footerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        tableView.tableFooterView = footerView
        
        tableView.separatorStyle = .none
        addRefreshControl()
    }
    
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    func addSpinnerToTableView() {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 44)
        spinner.hidesWhenStopped = false
        spinner.color = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        spinner.startAnimating()
        tableView.tableFooterView = spinner
    }
    
    private func removeBackgroundViews() {
        tableView.backgroundView = nil
    }
}

// MARK: - Actions
extension ProductsListViewController {
    
    @objc
    private func refreshData() {
        addFeedbackGenerator()
        viewModel.page = 1
        viewModel.perPage = 20
        viewModel.totalCount = 0
        getProducts()
    }
}

// MARK: - Requests
extension ProductsListViewController  {
    private func getProducts() {
        let currentPageCompletion: (() -> String) = { () in return "\(self.viewModel.page)" }
        
        if let model = componentModel {
            viewModel.getProducts(componentModel: model, currentPageCompletion: currentPageCompletion)
        }
    }
    
    func loadMoreProducts() {
        viewModel.page += 1
        getProducts()
    }
    
    private func setupResponse() {
        productsResponse()
        loadMoreProductsResponse()
    }
}

// MARK: - Responses
extension ProductsListViewController {
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.tableView.refreshControl?.endRefreshing()
            self.removeBackgroundViews()
            self.stopShimmerOn(tableView: self.tableView)
            self.reloadTableViewData()
            self.isReloadingTableView = false

            if self.viewModel.products.isEmpty {
//                self.setupEmptyView(type: .emptyScreen)
            }
        }
    }
    
    private func loadMoreProductsResponse() {
        viewModel.onLoadMoreProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.tableView.tableFooterView = nil
            self.reloadTableViewData()
            self.isReloadingTableView = false
            print("recieved")
        }
    }
}
