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
    @IBOutlet weak var subTotalPriceTitleLabel: UILabel!
    @IBOutlet weak var subTotalPriceLabel: UILabel!
    
    @IBOutlet weak var subtotalViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var quantityCircleViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var quantityDropDownViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var quantityCircleView: ProductDetailsQuantityCircleView!
    @IBOutlet private weak var quantityDropDownView: ProductDetailsQuantityDropDownView!


    var productModel: ProductModel?
    var viewModel: ProductDetailsViewModel!
    var combinationModel: ProductDetailsCombinationsModel?
    
    override  var prefersBottomBarHidden: Bool? { return true }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = " "
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
        quantityCircleView.delegate = self
        quantityDropDownView.delegate = self
        
        subTotalPriceTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        subTotalPriceLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        subTotalPriceTitleLabel.font = .appFont(ofSize: 17, weight: .bold)
        subTotalPriceLabel.font = .appFont(ofSize: 17, weight: .bold)
        
//        addToCartButton.setCornerRadius(24)
        addToCartButton.titleLabel?.font = .appFont(ofSize: 15, weight: .bold)
        addToCartButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        addToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        ThemeManager.setCornerRadious(element: addToCartButton, radius: 24)

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
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        if self.viewModel.productDetailsSettings?.actions == ProductDetailsActions.seperated.rawValue {
            self.setupNavigationBar()
        }
        
        if let settings = self.viewModel.productDetailsSettings {
            if settings.variants != ProductDetailsVarianrs.variants3.rawValue {
                deactivateQuantityView()
            }
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
    
    private func setupAddToCartView(_ combinationModel: ProductDetailsCombinationsModel) {
        UIView.transition(with: self.addToCartContainerView, duration: 1.5,
                          options: .curveEaseIn,
                          animations: {
            self.subtotalViewHeightConstraint.constant = 137
        })
        let subtotalPrice = (combinationModel.price ?? 0) * (self.viewModel.productModel?.quantitySelected ?? 0)
        subTotalPriceLabel.text = String(subtotalPrice) + L10n.ProductDetails.currency
    }
    
    private func activateQuantityView() {
        quantityDropDownView.alpha = 1
        quantityDropDownView.isUserInteractionEnabled = true
        
        quantityCircleView.alpha = 1
        quantityCircleView.isUserInteractionEnabled = true
    }
    
    private func deactivateQuantityView() {
        quantityDropDownView.alpha = 0.6
        quantityDropDownView.isUserInteractionEnabled = false
        
        quantityCircleView.alpha = 0.6
        quantityCircleView.isUserInteractionEnabled = false
    }
    
    private func checktoActivateQuantityAction() {
        if let model = self.combinationModel {
            
        }
    }
    
}

// MARK: - ProductDetailsQuantityDropDown
extension ProductDetailsViewController: ProductDetailsQuantityDelegate {
    func qunatitySelected(quantity: Int) {
        self.viewModel.productModel?.quantitySelected = quantity
        self.viewModel.productModel?.subtotalPrice = (self.viewModel.productModel?.currentPrice ?? 0) * quantity
        subTotalPriceLabel.text = String((self.viewModel.productModel?.currentPrice ?? 0) * quantity) + L10n.ProductDetails.currency
        self.tableView.reloadData()
    }
}

// MARK: - ProductDetailsVarientSelectedDelegate
extension ProductDetailsViewController: ProductDetailsVarientSelectedDelegate {
    func optionValueSelected(_ optionModel: ProductDetailsOptionsModel) {
        self.viewModel.selectedOptionsValues[String(optionModel.option?.id ?? 0)] = String(optionModel.optionValues?.filter({ $0.isSelected == true }).first?.id ?? 0)
        
        print("selectedOptionsValues = \(self.viewModel.selectedOptionsValues)")
        
        let combinationModel = self.viewModel.productModel?.selectedCombination
        if let model = combinationModel {
            self.combinationModel = model
            self.viewModel.productModel?.currentPrice = model.currentPrice
            self.viewModel.productModel?.originalPrice = model.price
            self.tableView.reloadSections([ProductDetailsSection.slider.rawValue], with: .none)
            activateQuantityView()
            setupAddToCartView(model)
        }
    }
}

// MARK: - ProductDetailsSliderDelegate
extension ProductDetailsViewController: ProductDetailsSliderDelegate {
    func seeMoreButtonClicked() {
        self.tableView.reloadData()
    }
}

extension ProductDetailsViewController: RecommentedProductsDelegate {
    func seeAllButtonClicked() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productList.rawValue})?.settings {
            switch settings.list {
            case ProductListDesign.list1.rawValue,
                ProductListDesign.list2.rawValue,
                ProductListDesign.list3.rawValue:
                let detailsVC = Coordinator.Controllers.createProductListViewController(componentModel: self.viewModel.componentModel)
                detailsVC.viewTitle = self.viewModel.productDetailsSettings?.recommendedProducts?.title
                detailsVC.productModel = self.viewModel.productModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            case ProductListDesign.grid1.rawValue,
                ProductListDesign.grid2.rawValue,
                ProductListDesign.grid3.rawValue,
                ProductListDesign.grid4.rawValue,
                ProductListDesign.grid5.rawValue:
                let detailsVC = Coordinator.Controllers.createProductsGridViewController(componentModel: self.viewModel.componentModel)
                detailsVC.viewTitle = self.viewModel.productDetailsSettings?.recommendedProducts?.title
                detailsVC.productModel = self.viewModel.productModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            default:
                return
            }
        }
    }
    
    func productClicked(_ model: ProductModel) {
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController(componentModel: self.viewModel.componentModel)
        detailsVC.productModel = model
        self.navigationController?.pushViewController(detailsVC, animated: true)
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
            UIView.transition(with: self.addToCartContainerView, duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.addToCartContainerView.isHidden = false
            })
            self.quantityCircleView.productModel = self.viewModel.productModel
            self.quantityDropDownView.productModel = self.viewModel.productModel
        }
    }
    
    private func relatedProductsResponse() {
        viewModel.onRelatedProducts = { [weak self] () in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
    }
}
