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
}

// MARK: - Private Func
extension CategoryDetailsListViewController {
    private func setupView() {
        isLoadingShimmer = true
        subcategoryTabsView.initialize()
        fillData()
        registerTableViewCells()
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0.0
        }
        
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        categoryNameLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        categoryNameLabel.font = .appFont(ofSize: 17, weight: .bold)
        
        if let settings = viewModel.categoryDetailsSettings {
            if (settings.coverPhoto?.isActive == "1") {
                coverPhotoContainerViewHeightContriant.constant = 180
                coverPhotoContainerView.isHidden = false
            } else {
                coverPhotoContainerViewHeightContriant.constant = 0
                coverPhotoContainerView.isHidden = true
            }
            
            if (settings.subcategoryTabs?.isActive == "1") { // TODO check for has subcategories
                switch settings.subcategoryTabs?.design {
                case SubcategoryTabsDesign.horizontal.rawValue:
                    subcategoriesContainerViewHeightContriant.constant = 40
                case SubcategoryTabsDesign.horizonta2.rawValue:
                    subcategoriesContainerViewHeightContriant.constant = 110
                default:
                    return
                }
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
    
    private func getProducts() {
        let currentPageCompletion: (() -> String) = { () in return "\(self.viewModel.page)" }
        if let categoryModel = categoryModel, let componentModel = componentModel {
            viewModel.getProducts(categoryId: categoryModel.id ?? 0,
                                  componentModel: componentModel,
                                  currentPageCompletion: currentPageCompletion)
        }
    }
    
    func loadMoreProducts() {
        viewModel.page += 1
        getProducts()
    }
    
    private func setupResponses() {
        categoryDetailsResponse()
        productsResponse()
        loadMoreProductsResponse()
    }
}

// MARK: - Responses
extension CategoryDetailsListViewController {
    private func categoryDetailsResponse() {
        viewModel.onSubCategories = { [weak self] () in
            guard let `self` = self else { return }
            print("Normal Reload")
            self.hideLoading()
            self.getProducts()
            self.subcategoryTabsView.subCategories = self.viewModel.subCategories
        }
    }
    
    private func productsResponse() {
        viewModel.onProducts = { [weak self] () in
            guard let `self` = self else { return }
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
            print("recieved")
        }
    }
}
