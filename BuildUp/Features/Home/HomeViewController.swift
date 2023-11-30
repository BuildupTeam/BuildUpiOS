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

    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()

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
        scrollToFirstRow()
        
        updateInfoPlist()
        
        getFirebaseToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
    
    func scrollToFirstRow() {
//        if viewModel.homeData.isAllDataValid {
            tableView.scrollToTopRow()
//            getHomeData()
//        }
    }
    
    private func updateInfoPlist() {
        let playersDictionaryPath = Bundle.main.path(forResource: "GoogleService-test", ofType: "plist")
        let playersDictionary = NSMutableDictionary(contentsOfFile: playersDictionaryPath!)
        if let projectId = playersDictionary?.object(forKey: "PROJECT_ID") as? String {
            playersDictionary?["PROJECT_ID"] = "my-app-3.ecommerce.buildupp.co"
//            print("playersDictionary = \(playersDictionary)")
            playersDictionary?.write(toFile: playersDictionaryPath!, atomically: true)
        }
        
        if let bundleId = playersDictionary?.object(forKey: "BUNDLE_ID") as? String {
            playersDictionary?["BUNDLE_ID"] = "com.sobhy.ibtikar"
//            print("playersDictionary = \(playersDictionary)")
            playersDictionary?.write(toFile: playersDictionaryPath!, atomically: true)
        }
    }
    
}

// MARK: - SetupUI
extension HomeViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()       
        setupNavigationBar()
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    private func setupNavigationBar() {
        let logoImageView = UIImageView(image: Asset.icSquadio.image)
        
        logoImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImageView
        
        let searchItem = UIBarButtonItem(
            image: Asset.icSearch.image,
            style: .plain,
            target: self,
            action: #selector(searchAction(sender:))
        )
        
        let notificationsItem = UIBarButtonItem(
            image: Asset.icNotifications.image,
            style: .plain,
            target: self,
            action: #selector(notificationAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItems = [searchItem, notificationsItem]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func startShimmer() {
        startShimmerOn(tableView: tableView)
    }
    
    private func addRefreshControl() {
        self.refreshControl.removeFromSuperview()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func getFirebaseToken() {
        viewModel.getFirebaseToken()
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    func notificationAction(sender: UIBarButtonItem) {
        PersistanceManager.setLatestViewController(Constant.ControllerName.subdomin)
        LauncherViewController.showSubdomainScreen(fromViewController: nil)
    }
    
    @objc
    func searchAction(sender: UIBarButtonItem) {
        PersistanceManager.setLatestViewController(Constant.ControllerName.subdomin)
        LauncherViewController.showSubdomainScreen(fromViewController: nil)
    }
    
    @objc
    private func refreshData() {
        self.getHomeData()
    }
}
// MARK: - Requests
extension HomeViewController {
    
    private func getHomeData() {
        self.viewModel.getHomeTemplate()
        self.viewModel.getCachedThemeData()
     }
    
    private func setupResponse() {
        homeResponse()
        cartItemUpdatedResponse()
    }
}

// MARK: - Responses
extension HomeViewController {
    
    private func homeResponse() {
        viewModel.onData = { [weak self] () in
            guard let `self` = self else { return }
            print("Normal Reload")
            containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
            self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
            
            self.hideLoading()
            self.tableView.refreshControl?.endRefreshing()
            self.addRefreshControl()
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
    private func cartItemUpdatedResponse() {
        ObservationService.carItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            //getProductsWithCartQuantity
            self.viewModel.updateAllHomeSectionsWithCartItems()
            self.tableView.reloadData()
            print("recieved")
        })
    }
}

// MARK: - HomeProductsCellDelegate
extension HomeViewController: HomeProductsCellDelegate {
    func homeProductTapped(productModel: ProductModel?, componentModel: ComponentConfigurationModel?) {
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController(componentModel: componentModel)
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
                        ProductListDesign.list2.rawValue,
                        ProductListDesign.list3.rawValue:
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

// MARK: - HomeHeaderCellDelegate
extension HomeViewController: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        if var products = self.viewModel.homeData.homeSections.first(where: { $0.component == homeSectionModel?.component })?.products {
            if let index = products.firstIndex(where: { $0.uuid == model.uuid }) {
                products[index].cartQuantity = model.cartQuantity
                self.viewModel.homeData.homeSections.first(where: { $0.component == homeSectionModel?.component })?.products = products
                
                self.tableView.reloadData()
            }
        }
         
    }
}
