//
//  CategoriesListViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 18/09/2023.
//

import UIKit

class CategoriesListViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    var componentModel: ComponentConfigurationModel?
    var refresher:UIRefreshControl!

    var viewModel: CategoriesViewModel!
//    var homeSectionModel: HomeSectionModel?
    
    init(viewModel: CategoriesViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResponse()
        getCategories()
        setupCell()
        startShimmerOn(collectionView: collectionView)
    }

}

// MARK: - Private Functions
extension CategoriesListViewController {
    private func setupCell() {
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindData() {
        
    }
}

extension CategoriesListViewController {
    
}
// MARK: - Requests
extension CategoriesListViewController  {
    private func getCategories() {
        let currentPageCompletion: (() -> String) = { () in return "\(self.viewModel.page)" }
        
        if let model = componentModel {
            viewModel.getCategories(componentModel: model, currentPageCompletion: currentPageCompletion)
        }
    }
    
    func loadMoreProducts() {
        viewModel.page += 1
        getCategories()
    }
    
    private func setupResponse() {
        categoriesResponse()
        loadMoreCategoriesResponse()
    }
}

// MARK: - Private Functions
extension CategoriesListViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerCollectionViewCells()
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        let footerView = UIView()
        footerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
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
    
    private func removeBackgroundViews() {
        collectionView.backgroundView = nil
    }
}

// MARK: - Actions
extension CategoriesListViewController {
    
    @objc
    private func refreshData() {
        addFeedbackGenerator()
        viewModel.page = 1
        viewModel.perPage = 20
        viewModel.totalCount = 0
        getCategories()
    }
}

// MARK: - Responses
extension CategoriesListViewController {
    private func categoriesResponse() {
        viewModel.onCategories = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
//            self.collectionView.refreshControl?.endRefreshing()
            self.refresher.endRefreshing()
            self.removeBackgroundViews()
            self.stopShimmerOn(collectionView: self.collectionView)
            self.reloadTableViewData()
            self.isReloadingTableView = false

            if self.viewModel.categories.isEmpty {
//                self.setupEmptyView(type: .emptyScreen)
            }
        }
    }
    
    private func loadMoreCategoriesResponse() {
        viewModel.onLoadMoreCategories = { [weak self] () in
            guard let `self` = self else { return }
            self.reloadTableViewData()
            self.isReloadingTableView = false
            print("recieved")
        }
    }
}
