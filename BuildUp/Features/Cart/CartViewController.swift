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
        setupResponses()
        startShimmerOn(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCart()
    }

}

// MARK: - Private Func
extension CartViewController {
    private func setupView() {
        isLoadingShimmer = true
        
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
    
    private func setupCartCheckoutType1View() {
        cartCheckoutType1View = CartCheckout1View.instantiateFromNib()
        cartCheckoutType1View?.initialize()
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
        cartCheckoutType2View = CartCheckout2View.instantiateFromNib()
        cartCheckoutType2View?.initialize()
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
        cartCheckoutType3View = CartCheckout3View.instantiateFromNib()
        cartCheckoutType3View?.initialize()
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
}

// MARK: - Requests
extension CartViewController {
    private func getCart() {
        viewModel.getCart()
    }
    private func setupResponses() {
        cartResponse()
    }
}

// MARK: - Responses
extension CartViewController {
    private func cartResponse() {
        viewModel.onCart = {[weak self] () in
            guard let `self` = self else { return }
            self.fillData()
            self.reloadTableViewData()
            self.isReloadingTableView = false
            self.stopShimmerOn(tableView: self.tableView)
        }
    }
}

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
            tableView.reloadData()
        }
    }
    
    private func calculateCartSubtotal() {
        var totalPriceOriginal = 0
        var totalPriceCurrent = 0
        
        if let cartModel = viewModel.cartModel {
            if let products = cartModel.products {
                for model in products {
                    if let combinations = model.combinations, !combinations.isEmpty {
                        totalPriceOriginal += (model.totalPriceOriginal ?? 0)
                        totalPriceCurrent += (model.totalPriceCurrent ?? 0)
                    } else {
                        totalPriceOriginal += (model.totalPriceOriginal ?? 0)
                        totalPriceCurrent += (model.totalPriceCurrent ?? 0)
                    }
                    
                }
                
                viewModel.cartModel?.subtotalBeforeDiscount = totalPriceOriginal
                viewModel.cartModel?.subtotal = totalPriceCurrent
            }
        }
    }
}
