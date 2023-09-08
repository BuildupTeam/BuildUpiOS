//
//  ProductDetailsViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import UIKit

class ProductDetailsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addToCartContainerView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var subtotalViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var quantityCircleViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var quantityDropDownViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var quantityCircleView: ProductDetailsQuantityCircleView!
    @IBOutlet private weak var quantityDropDownView: ProductDetailsQuantityDropDownView!


    var productModel: ProductModel?
    var viewModel: ProductDetailsViewModel!
    
    init(viewModel: ProductDetailsViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startShimmer()
        setupResponse()
        getProductDetailsData()
    }
    
    private func setupNavigationBar() {
        
        let cartButtonItem = UIBarButtonItem(
            image: Asset.productDetailsCart.image,
            style: .plain,
            target: self,
            action: #selector(cartBarAction(sender:))
        )
        
        let shareButtonItem = UIBarButtonItem(
            image: Asset.productDetailsShare.image,
            style: .plain,
            target: self,
            action: #selector(shareBarAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItems = [cartButtonItem, shareButtonItem]
    }

}

// MARK: - Actions
extension ProductDetailsViewController {
    
    @objc
    func cartBarAction(sender: UIBarButtonItem) {
        
    }
    
    @objc
    func shareBarAction(sender: UIBarButtonItem) {
        
    }
}

// MARK: - SetupUI
extension ProductDetailsViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        subtotalViewHeightConstraint.constant = 94
        quantityCircleView.initialize()
        
        addToCartButton.setCornerRadius(24)
        addToCartButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        addToCartButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        addToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        addToCartContainerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0.0
        }
        
        self.view.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        
        if self.viewModel.productDetailsSettings?.actions == ProductDetailsActions.seperated.rawValue {
            self.setupNavigationBar()
        }
        
        if let settings = self.viewModel.productDetailsSettings {
            if settings.quantityPosition == ProductDetailsQuantityPosition.upper.rawValue {
                addToCartButton.setCornerRadius(2)
                quantityCircleView.isHidden = true
                quantityDropDownView.isHidden = true
                quantityCircleViewWidthConstraint.constant = 0
                quantityDropDownViewWidthConstraint.constant = 0
            } else {
                if settings.quantityStyle == ProductDetailsQuantityStyle.dropdown.rawValue {
                    quantityDropDownViewWidthConstraint.constant = 128
                    quantityCircleView.isHidden = true
                    quantityDropDownView.isHidden = false
                } else {
                    quantityCircleViewWidthConstraint.constant = 133
                    quantityCircleView.isHidden = false
                    quantityDropDownView.isHidden = true
                }
            }
        }
    }
    
    private func startShimmer() {
        startShimmerOn(tableView: tableView)
    }
}

// MARK: - Requests
extension ProductDetailsViewController {
    
    private func getProductDetailsData() {
        if let model = self.productModel {
            self.viewModel.getProductDetails(uuid: model.uuid ?? "")
        }
     }
    
    private func setupResponse() {
        productDetailsResponse()
    }
}

// MARK: - Responses
extension ProductDetailsViewController {
    private func productDetailsResponse() {
        viewModel.onData = { [weak self] () in
            guard let `self` = self else { return }
            print("Normal Reload")
            self.hideLoading()
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
    private func relatedProductsResponse() {
        viewModel.onRelatedProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
    }
    
}
