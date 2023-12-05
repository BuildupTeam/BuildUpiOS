//
//  CategoriesTabViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import UIKit

class CategoriesTabViewController: BaseViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: CategoriesTabViewModel!
    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    
    init(viewModel: CategoriesTabViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionViewLayout()
        setupResponse()
        getCategories()
        
        startShimmerOn(collectionView: self.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = L10n.Categories.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }

}

// MARK: - Private Func
extension CategoriesTabViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        registerCollectionViewCells()
        self.viewModel.getCachedData()
        
        let footerView = UIView()
        footerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        tableView.tableFooterView = footerView
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        tableContainerView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")
        
        tableView.separatorStyle = .none
    }
    
    private func addRefreshControl() {
        self.refreshControl.removeFromSuperview()
        
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
extension CategoriesTabViewController {
    @objc
    private func refreshData() {
        addFeedbackGenerator()
        viewModel.page = 1
        viewModel.perPage = 20
        viewModel.totalCount = 0
        getCategories()
    }
}

// MARK: - Requests
extension CategoriesTabViewController  {
    private func getCategories() {
        self.viewModel.getCategories()
    }
    
    private func getProducts() {
        if let model = viewModel.categoryModel {
            self.viewModel.categoryModel = model
//            self.viewModel.getProducts(page: viewModel.page)
        }
    }
    
    func loadMoreProducts() {
        viewModel.page += 1
        getProducts()
    }
    
    private func setupResponse() {
        productsResponse()
        categoriesResponse()
        loadMoreProductsResponse()
        cartItemUpdatedResponse()
        favoriteProductUpdatedResponse()
    }
}

// MARK: - Delegates
extension CategoriesTabViewController {
    
}

// MARK: - Responses
extension CategoriesTabViewController {
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            stopShimmerOn(collectionView: self.collectionView)
            self.collectionView.reloadData()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.collectionView.reloadData()
//            }
        }
    }
    
    private func loadMoreProductsResponse() {
        viewModel.onLoadMoreProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.tableView.tableFooterView = nil
            self.reloadTableViewData()
            self.isReloadingTableView = false
        }
    }
    
    private func categoriesResponse() {
        viewModel.onCategories = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.reloadTableViewData()
            self.isReloadingTableView = false
            self.removeBackgroundViews()

            if self.viewModel.products.isEmpty {
//                self.setupEmptyView(type: .emptyScreen)
            }
        }
    }
    
    private func cartItemUpdatedResponse() {
        ObservationService.carItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.products = self.viewModel.getProductsWithCartQuantity(products: self.viewModel.products)
            self.tableView.reloadData()
        })
    }
    
    private func favoriteProductUpdatedResponse() {
        ObservationService.favItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.products = self.viewModel.getProductsWithFavorites(products: self.viewModel.products)
            self.tableView.reloadData()
        })
    }
}
