//
//  CartViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import UIKit

class CartViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var checkoutContainerView: UIView!
    @IBOutlet private weak var checkoutContainerViewHeightConstraint: NSLayoutConstraint!

    var cartCheckoutType1View: CartCheckout1View?
    var cartCheckoutType2View: CartCheckout2View?
    var cartCheckoutType3View: CartCheckout3View?
    
    var isReloadingTableView = false
    var viewModel: CartViewModel!
        
    init(viewModel: CartViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.viewModel.getCachedData()
        setupResponses()
        if CachingService.getUser() != nil {
            isLoadingShimmer = true
            startShimmerOn(tableView: tableView)
        } else {
            setupEmptyView(screenType: .loginFirst)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CachingService.getUser() != nil {
            getCart()
        }
        
//        self.navigationItem.title = L10n.Cart.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "
    }

}

// MARK: - Private Func
extension CartViewController {
    private func setupView() {
        self.checkoutContainerView.showView()
        setupNavigationvView()
        
        registerTableViewCells()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func fillData() {
        if let settings = viewModel.cartSettings {
            switch settings.cartButtonDesign {
            case CartCheckoutButtonDesign.checkoutButton1.rawValue:
                setupCartCheckoutType1View()
            case CartCheckoutButtonDesign.checkoutButton2.rawValue:
                setupCartCheckoutType2View()
            case CartCheckoutButtonDesign.checkoutButton3.rawValue:
                setupCartCheckoutType3View()
            default:
                return
            }
        }
    }
    
    private func setupNavigationvView(){
        let logoView = HomeLogoView.instantiateFromNib()
        logoView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoView.backgroundColor = .clear
        logoView.setupView()
        self.navigationItem.titleView = logoView
    }
    
    private func setupNavigationBar() {
        let logoImageView = UIImageView(image: Asset.icSquadio.image)
        
        logoImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImageView
        
        let clerCartItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: #selector(clearCartAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = clerCartItem
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
    
    private func setupCartCheckoutType1View() {
        if cartCheckoutType1View != nil {
            cartCheckoutType1View?.removeFromSuperview()
        }
        cartCheckoutType1View = CartCheckout1View.instantiateFromNib()
        cartCheckoutType1View?.initialize()
        cartCheckoutType1View?.delegate = self
        cartCheckoutType1View?.cartModel = self.viewModel.cartModel
        cartCheckoutType1View?.frame = CGRect(
            x: 0,
            y: 0,
            width: checkoutContainerView.bounds.width,
            height: 94)
        
        if cartCheckoutType1View != nil {
            checkoutContainerView.addSubview(cartCheckoutType1View!)
        }
    }
    
    private func setupCartCheckoutType2View() {
        if cartCheckoutType2View != nil {
            cartCheckoutType2View?.removeFromSuperview()
        }
        cartCheckoutType2View = CartCheckout2View.instantiateFromNib()
        cartCheckoutType2View?.initialize()
        cartCheckoutType2View?.delegate = self
        cartCheckoutType2View?.cartModel = self.viewModel.cartModel
        cartCheckoutType2View?.frame = CGRect(
            x: 0,
            y: 0,
            width: checkoutContainerView.bounds.width,
            height: 94)
        
        if cartCheckoutType2View != nil {
            checkoutContainerView.addSubview(cartCheckoutType2View!)
        }
    }
    
    private func setupCartCheckoutType3View() {
        if cartCheckoutType3View != nil {
            cartCheckoutType3View?.removeFromSuperview()
        }
        cartCheckoutType3View = CartCheckout3View.instantiateFromNib()
        cartCheckoutType3View?.initialize()
        cartCheckoutType3View?.delegate = self
        cartCheckoutType3View?.cartModel = self.viewModel.cartModel
        cartCheckoutType3View?.frame = CGRect(
            x: 0,
            y: 0,
            width: checkoutContainerView.bounds.width,
            height: 94)
        
        if cartCheckoutType3View != nil {
            checkoutContainerView.addSubview(cartCheckoutType3View!)
        }
    }
    
    func setupEmptyView(screenType: EmptyScreenType) {
        removeBackgroundViews()
        let emptyNib = EmptyScreenView.instantiateFromNib()
        emptyNib.frame = tableView.frame
        emptyNib.screenType = screenType
        
        if screenType == .loginFirst {
            emptyNib.showButton = true
            emptyNib.emptyImage = Asset.icLogin.image
            emptyNib.title = L10n.Popups.loginMsg
        } else {
            emptyNib.showButton = false
            emptyNib.emptyImage = Asset.noCartItems.image
            emptyNib.title = L10n.Cart.emptyMessage
        }
        tableView.backgroundView = emptyNib
    }
    
    func removeBackgroundViews() {
        tableView.backgroundView = nil
    }
    
    private func checkToClearPage() {
        if self.viewModel.cartModel?.products?.isEmpty ?? false {
            CachingService.setCartProducts(products: [:])
            RealTimeDatabaseService.clearCart()
            
            self.checkoutContainerView.hideView()
//            self.checkoutContainerViewHeightConstraint.constant = 0
            setupEmptyView(screenType: .emptyScreen)
        }
    }
}

// MARK: - @IBActions
extension CartViewController {
    @objc
    func clearCartAction(sender: UIBarButtonItem) {
        RealTimeDatabaseService.clearCart()
    }
}

// MARK: - Requests
extension CartViewController {
    private func getCart() {
        viewModel.getCart()
    }
    
    private func setupResponses() {
        cartResponse()
        favoriteProductUpdatedResponse()
    }
}

// MARK: - Responses
extension CartViewController {
    private func cartResponse() {
        viewModel.onCart = {[weak self] () in
            guard let `self` = self else { return }
            self.reloadTableViewData()
            self.isReloadingTableView = false
            self.stopShimmerOn(tableView: self.tableView)
            
            if self.viewModel.cartModel != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.fillData()
                    self.checkoutContainerView.showView()
//                    self.checkoutContainerViewHeightConstraint.constant = 80
                }
                self.removeBackgroundViews()
            } else {
                DispatchQueue.main.async {
                    self.checkoutContainerView.hideView()
//                    self.checkoutContainerViewHeightConstraint.constant = 0
                }
                self.setupEmptyView(screenType: .emptyScreen)
            }
        }
    }
    
    private func favoriteProductUpdatedResponse() {
        ObservationService.favItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            self.viewModel.cartModel?.products = self.viewModel.getProductsWithFavorites(products: self.viewModel.cartModel?.products ?? [])
            self.tableView.reloadData()
        })
    }
}

// MARK: - Products List Delegates
extension CartViewController: CartProductListDelegate {
    func quantityChanged(quantity: Int, model: ProductModel) {
        if let index = self.viewModel.cartModel?.products?.firstIndex(where: { $0 == model }) {
            viewModel.cartModel?.products?[index] = model
            calculateCartSubtotal()
            tableView.reloadData()
        }
    }
    
    func removeButtonClicked(model: ProductModel) {
        if let index = viewModel.cartModel?.products?.firstIndex(where: { $0 == model }) {
            viewModel.cartModel?.products?.remove(at: index)
            calculateCartSubtotal()
            checkToClearPage()
            tableView.reloadData()
        }
    }
    
    private func calculateCartSubtotal() {
        var totalPriceOriginal = 0.0
        var totalPriceCurrent = 0.0
        
        if let cartModel = viewModel.cartModel {
            if let products = cartModel.products {
                for model in products {
                    if let combinations = model.combinations, !combinations.isEmpty {
                        totalPriceOriginal += (model.totalPriceCombinationOriginal ?? 0)
                        totalPriceCurrent += (model.totalPriceCombinationCurrent ?? 0)
                    } else {
                        totalPriceOriginal += (model.totalPriceOriginal ?? 0)
                        totalPriceCurrent += (model.totalPriceCurrent ?? 0)
                    }
                }
                
                viewModel.cartModel?.subtotalBeforeDiscount?.amount = totalPriceOriginal
                viewModel.cartModel?.formattedSubtotal?.amount = totalPriceCurrent
                fillData()
            }
        }
    }
}

// MARK: - Checkout Button Delegates
extension CartViewController: CartCheckoutDelegate {
    func checkoutButtonClicked() {
//        let checkoutShippingVC = Coordinator.Controllers.createCheckoutShippingViewController()
//        self.navigationController?.pushViewController(checkoutShippingVC, animated: true)
        
        let checkoutVC = Coordinator.Controllers.createCheckoutViewController()
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
}
