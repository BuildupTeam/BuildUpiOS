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
    @IBOutlet private weak var titleLabel: UILabel!

    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    var componentModel: ComponentConfigurationModel?
    var productModel: ProductModel?
    
    var viewTitle: String?
    
    override  var prefersBottomBarHidden: Bool? { return true }

    // MARK: - Private Variables
    
    var viewModel: ProductListViewModel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.Login.Empty.navigation, style: .plain, target: nil, action: nil)
    }
}

// MARK: - Private Functions
extension ProductsListViewController {
    private func setupView() {
        if let title = viewTitle {
            titleLabel.text = title
        } else {
            titleLabel.text = componentModel?.title
        }
        
        titleLabel.font = .appFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        isLoadingShimmer = true
        registerTableViewCells()
        let footerView = UIView()
        footerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        tableView.tableFooterView = footerView
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        tableView.separatorStyle = .none
        setupNavigationBar()
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
    
    private func showLoginPopup() {
        let loginVC = LoginPopupViewController()
        loginVC.delegate = self
        self.presentPanModal(loginVC)
    }
}

// MARK: - Popup Delegate
extension ProductsListViewController: LoginPopupProtocol {
    func loginButtonClicked() {
        LauncherViewController.showLoginView(fromViewController: nil)
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

// MARK: - HomeHeaderCellDelegate
extension ProductsListViewController: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        
    }
    
    func userShouldLoginFirst() {
        self.showLoginPopup()
    }
}

// MARK: - TableViewDelegate & DataSource
extension ProductsListViewController: ProductFavoriteDelegate {
    func productFavorite(model: ProductModel) {
//        if let index = self.viewModel.products.firstIndex(where: { $0.uuid == model.uuid }) {
//            self.viewModel.products.remove(at: index)
//            self.tableView.reloadData()
//        }
    }
    
    func pleaseLoginFirst() {
        showLoginPopup()
    }
}

// MARK: - Requests
extension ProductsListViewController  {
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

// MARK: - Responses
extension ProductsListViewController {
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.tableView.refreshControl?.endRefreshing()
            self.addRefreshControl()
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
