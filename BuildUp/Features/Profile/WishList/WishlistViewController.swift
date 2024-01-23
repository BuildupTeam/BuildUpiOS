//
//  WishlistViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import UIKit
import PanModal

class WishlistViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: WishListViewModel!
    
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: WishListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResponses()
        setupView()
        self.getWishlist()
        startShimmerOn(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = L10n.Profile.wishlist
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }

}

// MARK: - Private Functions
extension WishlistViewController {
    private func setupView() {
        registerTableViewCells()
        isLoadingShimmer = true
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func checkIfProductsEmpty() {
        if self.viewModel.products?.isEmpty ?? false {
            self.setupEmptyView()
        } else {
            self.removeBackgroundViews()
        }
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
    
    private func getWishlist() {
        self.viewModel.getWishList()
    }
    
    private func setupResponses() {
        wishlistResponses()
        cartItemUpdatedResponse()
        favoriteProductUpdatedResponse()
    }
    
    private func wishlistResponses() {
        self.viewModel.onWishList = { [weak self]() in
            guard let `self` = self else { return }
            if self.viewModel.products?.isEmpty ?? false {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.tableView.reloadData()
            self.stopShimmerOn(tableView: self.tableView)
        }
    }
    
    private func cartItemUpdatedResponse() {
        ObservationService.carItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.products = self.viewModel.getProductsWithCartQuantity(products: self.viewModel.products ?? [])
            self.tableView.reloadData()
        })
    }
    
    private func favoriteProductUpdatedResponse() {
        ObservationService.favItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.products = self.viewModel.getProductsWithFavorites(products: self.viewModel.products ?? [])
            self.tableView.reloadData()
        })
    }
    
    private func showLoginPopup() {
        let loginVC = LoginPopupViewController()
        loginVC.delegate = self
        self.presentPanModal(loginVC)
    }
}

// MARK: - Popup Delegate
extension WishlistViewController: LoginPopupProtocol {
    func loginButtonClicked() {
        LauncherViewController.showLoginView(fromViewController: nil)
    }
}

// MARK: Register TableView Cells
extension WishlistViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: ProductVerticalList3InnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList3InnerTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerProductVerticalListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductVerticalListTableViewCell.identifier)
    }
}

// MARK: - TableViewDelegate & DataSource
extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.products?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerProductVerticalListTableViewCell.identifier,
                for: indexPath) as? ShimmerProductVerticalListTableViewCell
            else { return UITableViewCell() }
            
            cell.isExclusiveTouch = true
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList3InnerTableViewCell.identifier,
            for: indexPath) as? ProductVerticalList3InnerTableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = self.viewModel.products?[indexPath.row]
        cell.delegate = self
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productModel = viewModel.products?[indexPath.row]
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController(productModel: productModel)
        detailsVC.productModel = productModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - TableViewDelegate & DataSource
extension WishlistViewController: ProductFavoriteDelegate {
    func productFavorite(model: ProductModel) {
        if let index = self.viewModel.products?.firstIndex(where: { $0.uuid == model.uuid }) {
            self.viewModel.products?.remove(at: index)
            self.tableView.reloadData()
            self.checkIfProductsEmpty()
        }
    }
    
    func pleaseLoginFirst() {
        showLoginPopup()
    }
}
