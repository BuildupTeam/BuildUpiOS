//
//  ProductstGridViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import UIKit

class ProductsGridViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    var componentModel: ComponentConfigurationModel?
    var refresher:UIRefreshControl!
    
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
        startShimmerOn(collectionView: collectionView)
    }
}

// MARK: - Private Functions
extension ProductsGridViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerCollectionViewCells()
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        let footerView = UIView()
        footerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
//        collectionView.foo = footerView
        
        addRefreshControl()
    }
    
    private func addRefreshControl() {
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.collectionView.reloadData()
    }
    
//    func addSpinnerToTableView() {
//        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
//        spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 44)
//        spinner.hidesWhenStopped = false
//        spinner.color = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
//        spinner.startAnimating()
//        tableView.tableFooterView = spinner
//    }
    
    private func removeBackgroundViews() {
        collectionView.backgroundView = nil
    }
}

// MARK: - Actions
extension ProductsGridViewController {
    
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
extension ProductsGridViewController  {
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
extension ProductsGridViewController {
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
//            self.collectionView.refreshControl?.endRefreshing()
            self.removeBackgroundViews()
            self.stopShimmerOn(collectionView: self.collectionView)
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
            self.reloadTableViewData()
            self.isReloadingTableView = false
            print("recieved")
        }
    }
}
