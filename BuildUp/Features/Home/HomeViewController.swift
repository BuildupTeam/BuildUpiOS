//
//  HomeViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!

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
        startShimmer()
        setupResponse()
        getHomeData()
    }
    
}

// MARK: - SetupUI
extension HomeViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        setupNavigationBar()
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0.0
        }
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
    }
    
    private func setupNavigationBar() {
        
        let refreshItem = UIBarButtonItem(
            image: Asset.productDetailsCart.image,
            style: .plain,
            target: self,
            action: #selector(refreshAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = refreshItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func startShimmer() {
        startShimmerOn(tableView: tableView)
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    func refreshAction(sender: UIBarButtonItem) {
        self.getHomeData()
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
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
}

// MARK: - HomeProductsCellDelegate
extension HomeViewController: HomeProductsCellDelegate {
    func homeProductTapped(productModel: ProductModel?) {
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController()
        detailsVC.productModel = productModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - HomeCategoriesCellDelegate
extension HomeViewController: HomeCategoriesCellDelegate {
    func homeCategoryTapped(categoryModel: CategoryModel?, componentModel: ComponentConfigurationModel?) {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoryDetails.rawValue})?.settings {
            switch settings.productsList?.design {
            case ProductListDesign.list1.rawValue,
                ProductListDesign.list2.rawValue,
                ProductListDesign.list3.rawValue:
                let detailsVC = Coordinator.Controllers.createCategoryDetailsListViewController(categoryModel: categoryModel)
                detailsVC.categoryModel = categoryModel
                detailsVC.componentModel = componentModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            default:
                let detailsVC = Coordinator.Controllers.createCategoryDetailsGridViewController(categoryModel: categoryModel)
                detailsVC.categoryModel = categoryModel
                detailsVC.componentModel = componentModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }
}

// MARK: - HomeHeaderCellDelegate
extension HomeViewController: HomeHeaderCellDelegate {
    func seeAllButtonClicked(_ homeSectionModel: HomeSectionModel) {
        if let contentType = homeSectionModel.component?.contentType {
            switch contentType {
            case HomeContentType.products.rawValue:
                if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productList.rawValue})?.settings {
                    switch settings.list {
                    case ProductListDesign.list1.rawValue,
                        ProductListDesign.list2.rawValue:
                        let detailsVC = Coordinator.Controllers.createProductListViewController(homeSectionModel: homeSectionModel)
                        detailsVC.componentModel = homeSectionModel.component
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    case ProductListDesign.grid1.rawValue,
                        ProductListDesign.grid2.rawValue,
                        ProductListDesign.grid3.rawValue,
                        ProductListDesign.grid4.rawValue,
                        ProductListDesign.grid5.rawValue:
                        let detailsVC = Coordinator.Controllers.createProductsGridViewController(homeSectionModel: homeSectionModel)
                        detailsVC.componentModel = homeSectionModel.component
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    default:
                        return
                    }
                }
            case HomeContentType.categories.rawValue:
                let detailsVC = Coordinator.Controllers.createCategoryListViewController(homeSectionModel: homeSectionModel)
                detailsVC.componentModel = homeSectionModel.component
                self.navigationController?.pushViewController(detailsVC, animated: true)
            default:
                return
            }
        }
    }
}
