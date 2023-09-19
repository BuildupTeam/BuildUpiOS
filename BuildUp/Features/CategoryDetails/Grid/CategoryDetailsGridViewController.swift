//
//  CategoryDetailsGridViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import UIKit

enum CategoryDetailsCoverPhotoDesign: String {
    case coverPhoto1 = "cover-photo-1"
    case coverPhoto2 = "cover-photo-2"
    case coverPhoto3 = "cover-photo-3"
}

class CategoryDetailsGridViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var coverPhotoContainerView: UIView!
    @IBOutlet private weak var subcategoryTabsView: SubcategoryTabsView!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var subcategoriesContainerViewHeightContriant: NSLayoutConstraint!
    @IBOutlet weak var coverPhotoContainerViewHeightContriant: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightContriant: NSLayoutConstraint!
    
    var categoryModel: CategoryModel?
    var componentModel: ComponentConfigurationModel?
    var viewModel: CategoryDetailsViewModel!
    var isReloadingCollectionView = false
    
    var coverPhotoType1View: CategoryDetailsCoverPhoto1?
    var coverPhotoType2View: CategoryDetailsCoverPhoto2?
    var coverPhotoType3View: CategoryDetailsCoverPhoto3?

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
        startShimmerOn(collectionView: collectionView)
    }
}

// MARK: - Private Func
extension CategoryDetailsGridViewController {
    private func setupView() {
        isLoadingShimmer = true
        subcategoryTabsView.initialize()
        fillData()
        registerCollectionViewCells()
        
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
    
    private func reloadCollectionViewData() {
        self.isReloadingCollectionView = true
        self.collectionView.reloadData()
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
extension CategoryDetailsGridViewController {
    
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
extension CategoryDetailsGridViewController {
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
            self.reloadCollectionViewData()
            self.isReloadingCollectionView = false
            self.stopShimmerOn(collectionView: collectionView)
        }
    }
    
    private func loadMoreProductsResponse() {
        viewModel.onLoadMoreProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.reloadCollectionViewData()
            self.isReloadingCollectionView = false
            print("recieved")
        }
    }
}
