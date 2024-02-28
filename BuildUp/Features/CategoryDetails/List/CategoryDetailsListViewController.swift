//
//  CategoryDetailsViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import UIKit

class CategoryDetailsListViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var coverPhotoContainerView: UIView!
    @IBOutlet private weak var subcategoryTabsView: SubcategoryTabsView!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var subcategoriesContainerViewHeightContriant: NSLayoutConstraint!
    @IBOutlet weak var coverPhotoContainerViewHeightContriant: NSLayoutConstraint!
    
    var categoryModel: CategoryModel?
    var componentModel: ComponentConfigurationModel?
    var viewModel: CategoryDetailsViewModel!
    var isReloadingTableView = false

    var coverPhotoType1View: CategoryDetailsCoverPhoto1?
    var coverPhotoType2View: CategoryDetailsCoverPhoto2?
    var coverPhotoType3View: CategoryDetailsCoverPhoto3?

    override  var prefersBottomBarHidden: Bool? { return true }
    
    init(viewModel: CategoryDetailsViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResponses()
        getCategoryDetailsData()
        setupView()
        startShimmerOn(tableView: tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
}

// MARK: - Private Func
extension CategoryDetailsListViewController {
    private func setupView() {
        isLoadingShimmer = true
        subcategoryTabsView.initialize()
        subcategoryTabsView.delegate = self
        fillData()
        registerTableViewCells()
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0.0
        }
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        categoryNameLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        categoryNameLabel.font = .appFont(ofSize: 17, weight: .bold)
        
        if let settings = viewModel.categoryDetailsSettings {
            if (settings.coverPhoto?.isActive ?? false) {
                coverPhotoContainerViewHeightContriant.constant = 180
                coverPhotoContainerView.isHidden = false
            } else {
                coverPhotoContainerViewHeightContriant.constant = 0
                coverPhotoContainerView.isHidden = true
            }
            
            if (settings.subcategoryTabs?.isActive ?? false) { // TODO check for has subcategories
                subcategoriesContainerViewHeightContriant.constant = 40
                subcategoryTabsView.isHidden = false
            } else {
                subcategoriesContainerViewHeightContriant.constant = 0
                subcategoryTabsView.isHidden = true
            }
        }
    }
    
    private func fillData() {
        if let model = categoryModel {
            categoryNameLabel.text = model.name
            if let settings = viewModel.categoryDetailsSettings {
                switch settings.coverPhoto?.design {
                case CategoryDetailsCoverPhotoDesign.coverPhoto1.rawValue:
                    setupCoverPhotoType1View()
                case CategoryDetailsCoverPhotoDesign.coverPhoto2.rawValue:
                    setupCoverPhotoType2View()
                case CategoryDetailsCoverPhotoDesign.coverPhoto3.rawValue:
                    setupCoverPhotoType3View()
                    categoryNameLabel.isHidden = true
                default:
                    return
                }
            }
        }
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
    
    private func setupEmptyView() {
        removeBackgroundViews()
        let emptyNib = EmptyScreenView.instantiateFromNib()
        emptyNib.frame = tableView.backgroundView?.frame ?? CGRect()
        emptyNib.title = L10n.EmptyScreen.noData
//        emptyNib.emptyImage = Asset.icEmptyViewSearch.image
        emptyNib.showButton = false
        tableView.backgroundView = emptyNib
    }
    
    private func removeBackgroundViews() {
        tableView.backgroundView = nil
    }
    
    private func setupCoverPhotoType1View() {
        coverPhotoType1View = CategoryDetailsCoverPhoto1.instantiateFromNib()
        coverPhotoType1View?.initialize()
        coverPhotoType1View?.categoryModel = self.categoryModel
        coverPhotoType1View?.frame = CGRect(
            x: 0,
            y: 0,
            width: coverPhotoContainerView.bounds.width,
            height: 160)
        
        
        if coverPhotoType1View != nil {
            coverPhotoContainerView.addSubview(coverPhotoType1View!)
        }
    }
    
    private func setupCoverPhotoType2View() {
        coverPhotoType2View = CategoryDetailsCoverPhoto2.instantiateFromNib()
        coverPhotoType2View?.initialize()
        coverPhotoType2View?.categoryModel = self.categoryModel
        coverPhotoType2View?.frame = CGRect(
            x: 0,
            y: 0,
            width: coverPhotoContainerView.bounds.width,
            height: 160)
        
        
        if coverPhotoType2View != nil {
            coverPhotoContainerView.addSubview(coverPhotoType2View!)
        }
    }
    
    private func setupCoverPhotoType3View() {
        coverPhotoType3View = CategoryDetailsCoverPhoto3.instantiateFromNib()
        coverPhotoType3View?.initialize()
        coverPhotoType3View?.categoryModel = self.categoryModel
        coverPhotoType3View?.frame = CGRect(
            x: 0,
            y: 0,
            width: coverPhotoContainerView.bounds.width,
            height: 160)
        
        
        if coverPhotoType3View != nil {
            coverPhotoContainerView.addSubview(coverPhotoType3View!)
        }
    }
}

// MARK: - Requests
extension CategoryDetailsListViewController {
    
    private func getCategoryDetailsData() {
        self.viewModel.getSubCategories()
     }
    
    private func getProducts(_ categoryId: Int) {
        let currentPageCompletion: (() -> String) = { () in return "\(self.viewModel.page)" }
        if let categoryModel = categoryModel, let componentModel = componentModel {
            viewModel.getProducts(categoryId: categoryId,
                                  componentModel: componentModel,
                                  currentPageCompletion: currentPageCompletion)
        }
    }
    
    func loadMoreProducts() {
        viewModel.page += 1
        getProducts(self.categoryModel?.id ?? 0)
    }
    
    private func setupResponses() {
        categoryDetailsResponse()
        productsResponse()
        loadMoreProductsResponse()
        cartItemUpdatedResponse()
        favoriteProductUpdatedResponse()
    }
    
    private func showLoginPopup() {
        let loginVC = LoginPopupViewController()
        loginVC.delegate = self
        self.presentPanModal(loginVC)
    }
}

// MARK: - Popup Delegate
extension CategoryDetailsListViewController: LoginPopupProtocol {
    func loginButtonClicked() {
        LauncherViewController.showLoginView(fromViewController: nil)
    }
}

// MARK: - HomeHeaderCellDelegate
extension CategoryDetailsListViewController: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        
    }
    
    func userShouldLoginFirst() {
        self.showLoginPopup()
    }
}

// MARK: - TableViewDelegate & DataSource
extension CategoryDetailsListViewController: ProductFavoriteDelegate {
    func productFavorite(model: ProductModel) {
        if let index = self.viewModel.products.firstIndex(where: { $0.uuid == model.uuid }) {
            self.viewModel.products.remove(at: index)
            self.tableView.reloadData()
        }
    }
    
    func pleaseLoginFirst() {
        showLoginPopup()
    }
}

extension CategoryDetailsListViewController: subcategoryTabsViewDelegate {
    func subcategoryClicked(_ model: CategoryModel) {
        isLoadingShimmer = true
        startShimmerOn(tableView: tableView)
        getProducts(model.id ?? 0)
    }
}

// MARK: - Responses
extension CategoryDetailsListViewController {
    private func categoryDetailsResponse() {
        viewModel.onSubCategories = { [weak self] () in
            guard let `self` = self else { return }
            print("Normal Reload")
            self.hideLoading()
            self.getProducts(self.categoryModel?.id ?? 0)
            self.subcategoryTabsView.subCategories = self.viewModel.subCategories
            
            if self.viewModel.subCategories.isEmpty {
                self.subcategoriesContainerViewHeightContriant.constant = 0
                self.subcategoryTabsView.isHidden = true
            }
        }
    }
    
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
            if self.viewModel.products.isEmpty {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.reloadTableViewData()
            self.isReloadingTableView = false
            self.stopShimmerOn(tableView: self.tableView)
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
