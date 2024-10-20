//
//  ProductstGridViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import UIKit

class ProductsGridViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    var componentModel: ComponentConfigurationModel?
    var refresher:UIRefreshControl!
    var viewTitle: String?
    var productModel: ProductModel?

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
        startShimmerOn(collectionView: collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.Login.Empty.navigation, style: .plain, target: nil, action: nil)
    }
}

// MARK: - Private Functions
extension ProductsGridViewController {
    private func setupView() {
        if let title = viewTitle {
            titleLabel.text = title
        } else {
            titleLabel.text = componentModel?.title
        }
        
        titleLabel.font = .appFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        isLoadingShimmer = true
        registerCollectionViewCells()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        setupNavigationBar()
    }
    
    private func addRefreshControl() {
        if let refresher = self.refresher {
            self.refresher.removeFromSuperview()
        }
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
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
    
    private func setupNavigationBar() {
        
        let cartItem = UIBarButtonItem(
            image: Asset.productDetailsCart.image,
            style: .plain,
            target: self,
            action: #selector(cartAction(sender:))
        )
        
        let shareItem = UIBarButtonItem(
            image: Asset.productDetailsShare.image,
            style: .plain,
            target: self,
            action: #selector(shareAction(sender:))
        )
        
//        self.navigationItem.rightBarButtonItems = [cartItem, shareItem]
        self.navigationItem.rightBarButtonItem = cartItem
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
        viewModel.cursor = nil
        getProducts()
    }
    
    @objc
    func cartAction(sender: UIBarButtonItem) {
        
    }
    
    @objc
    func shareAction(sender: UIBarButtonItem) {
        
    }
}

// MARK: - Requests
extension ProductsGridViewController  {
    private func getProducts() {
        let currentPageCompletion: (() -> String) = { () in return "\(self.viewModel.page)" }
        
        if let model = productModel {
            viewModel.getProducts(productModel: model, currentPageCompletion: currentPageCompletion)
        } else {
            if let model = self.componentModel {
                viewModel.getComponentProductList(componentModel: model, currentPageCompletion: currentPageCompletion)
            }
        }
    }
    
    func loadMoreProducts() {
        viewModel.page += 1
        getProducts()
    }
    
    private func setupResponse() {
        productsResponse()
        loadMoreProductsResponse()
        cartItemUpdatedResponse()
        favoriteProductUpdatedResponse()
    }
}

// MARK: - TableViewDelegate & DataSource
extension ProductsGridViewController: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        
    }
    
    func userShouldLoginFirst() {
        self.showLoginPopup()
    }
    
    private func showLoginPopup() {
        let loginVC = LoginPopupViewController()
        loginVC.delegate = self
        self.presentPanModal(loginVC)
    }
}

extension ProductsGridViewController: ProductFavoriteDelegate {
    func productFavorite(model: ProductModel) {
        
    }
    
    func pleaseLoginFirst() {
        showLoginPopup()
    }
}

// MARK: - Popup Delegate
extension ProductsGridViewController: LoginPopupProtocol {
    func loginButtonClicked() {
        LauncherViewController.showLoginView(fromViewController: nil)
    }
}

// MARK: - Responses
extension ProductsGridViewController {
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            if let refresher = self.refresher {
                self.refresher.endRefreshing()
            }
            self.addRefreshControl()
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
        }
    }
    
    private func cartItemUpdatedResponse() {
        ObservationService.carItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.products = self.viewModel.getProductsWithCartQuantity(products: self.viewModel.products)
            self.collectionView.reloadData()
        })
    }
    
    private func favoriteProductUpdatedResponse() {
        ObservationService.favItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.products = self.viewModel.getProductsWithFavorites(products: self.viewModel.products)
            self.collectionView.reloadData()
        })
    }
}
