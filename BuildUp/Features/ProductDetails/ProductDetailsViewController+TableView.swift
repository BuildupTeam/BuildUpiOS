//
//  ProductDetailsViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/09/2023.
//

import Foundation
import UIKit

enum ProductDetailsSection: Int {
    case slider = 0
    case quantity
    case variants
    case recommendedProducts
}

enum ProductDetailsSliderType: String {
    case productDetailsSlider1 = "slider-1"
    case productDetailsSlider2 = "slider-2"
}

enum ProductDetailsActions: String {
    case grouped = "grouped"
    case seperated = "seperated"
}

enum ProductDetailsVarianrs: String {
    case variants1 = "variants-1"
    case variants2 = "variants-2"
    case variants3 = "variants-3"
}

enum ProductDetailsQuantityPosition: String {
    case upper = "upper"
    case bottom = "bottom"
}

enum ProductDetailsQuantityStyle: String {
    case dropdown = "dropdown"
    case circle = "circle"
}

enum RecommendedProductsDesign: String {
    case horizontal = "product-horizontal-list-1"
    case grid1 = "product-vertical-grid-1"
    case grid2 = "product-vertical-grid-2"
}

// MARK: Register TableView Cells
extension ProductDetailsViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: ProductDetailsSliderType1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsSliderType1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsSliderType2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsSliderType2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsSliderType3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsSliderType3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsAddToCartType1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsAddToCartType1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsAddToCartType3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsAddToCartType3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsVariants1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsVariants1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsVariants2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsVariants2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsVariants3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsVariants3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsSizeChartTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsSizeChartTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductSpecificationsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductSpecificationsTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RecommentedProductsType1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RecommentedProductsType1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RecommentedProductsType2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RecommentedProductsType2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RecommendedProductsType3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RecommendedProductsType3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsQuantityCircleTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsQuantityCircleTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductDetailsQuantityDropDownTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsQuantityDropDownTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductHorizontalList1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductHorizontalList1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerProductDetailsSilderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductDetailsSilderTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerProductDetailsVariantsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductDetailsVariantsTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerProductDetailsQuantityTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductDetailsQuantityTableViewCell.identifier)
    }
}

extension ProductDetailsViewController {
    private func getShimmerProductDetailsSilderTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerProductDetailsSilderTableViewCell.identifier,
            for: indexPath) as? ShimmerProductDetailsSilderTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getShimmerProductDetailsVariantsTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerProductDetailsVariantsTableViewCell.identifier,
            for: indexPath) as? ShimmerProductDetailsVariantsTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getShimmerProductDetailsQuantityTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerProductDetailsQuantityTableViewCell.identifier,
            for: indexPath) as? ShimmerProductDetailsQuantityTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsSlider1Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsSliderType1TableViewCell.identifier,
            for: indexPath) as? ProductDetailsSliderType1TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsSlider2Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsSliderType2TableViewCell.identifier,
            for: indexPath) as? ProductDetailsSliderType2TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsVariants1Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsVariants1TableViewCell.identifier,
            for: indexPath) as? ProductDetailsVariants1TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.optionModel = productModel.options?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsVariants2Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsVariants2TableViewCell.identifier,
            for: indexPath) as? ProductDetailsVariants2TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.optionModel = productModel.options?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsVariants3Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsVariants3TableViewCell.identifier,
            for: indexPath) as? ProductDetailsVariants3TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.optionModel = productModel.options?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsQuantityCircleCell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsQuantityCircleTableViewCell.identifier,
            for: indexPath) as? ProductDetailsQuantityCircleTableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductDetailsQuantityDropDownCell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsQuantityDropDownTableViewCell.identifier,
            for: indexPath) as? ProductDetailsQuantityDropDownTableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getRelatedProductsHorizontalCell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecommentedProductsType1TableViewCell.identifier,
            for: indexPath) as? RecommentedProductsType1TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getRelatedProductsGrid1Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecommentedProductsType2TableViewCell.identifier,
            for: indexPath) as? RecommentedProductsType2TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getRelatedProductsGrid2Cell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecommendedProductsType3TableViewCell.identifier,
            for: indexPath) as? RecommendedProductsType3TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: Dynamic Components
extension ProductDetailsViewController {
    func getCellForSection(indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            switch indexPath.section {
            case ProductDetailsSection.slider.rawValue:
                return self.getShimmerProductDetailsSilderTableViewCell(indexPath: indexPath)
            case ProductDetailsSection.quantity.rawValue:
                return self.getShimmerProductDetailsQuantityTableViewCell(indexPath: indexPath)
            case ProductDetailsSection.variants.rawValue:
                return self.getShimmerProductDetailsVariantsTableViewCell(indexPath: indexPath)
            default:
                return UITableViewCell()
            }
        } else {
            guard let productModel = viewModel.productModel else {
                return UITableViewCell()
            }
            
            switch indexPath.section {
            case ProductDetailsSection.slider.rawValue:
                if let settings = viewModel.productDetailsSettings {
                    switch settings.slider {
                    case ProductDetailsSliderType.productDetailsSlider1.rawValue:
                        return self.getProductDetailsSlider1Cell(indexPath: indexPath, productModel: productModel)
                    case ProductDetailsSliderType.productDetailsSlider2.rawValue:
                        return self.getProductDetailsSlider2Cell(indexPath: indexPath, productModel: productModel)
                    default:
                        return UITableViewCell()
                    }
                }
            case ProductDetailsSection.quantity.rawValue:
                if let settings = viewModel.productDetailsSettings {
                    switch settings.quantityStyle {
                    case ProductDetailsQuantityStyle.circle.rawValue:
                        return self.getProductDetailsQuantityCircleCell(indexPath: indexPath, productModel: productModel)
                    case ProductDetailsQuantityStyle.dropdown.rawValue:
                        return self.getProductDetailsQuantityDropDownCell(indexPath: indexPath, productModel: productModel)
                    default:
                        return UITableViewCell()
                    }
                }
            case ProductDetailsSection.variants.rawValue:
                if let settings = viewModel.productDetailsSettings {
                    switch settings.variants {
                    case ProductDetailsVarianrs.variants1.rawValue:
                        return self.getProductDetailsVariants1Cell(indexPath: indexPath, productModel: productModel)
                    case ProductDetailsVarianrs.variants2.rawValue:
                        return self.getProductDetailsVariants2Cell(indexPath: indexPath, productModel: productModel)
                    case ProductDetailsVarianrs.variants3.rawValue:
                        return self.getProductDetailsVariants3Cell(indexPath: indexPath, productModel: productModel)
                    default:
                        return UITableViewCell()
                    }
                }
            case ProductDetailsSection.recommendedProducts.rawValue:
                if let settings = viewModel.productDetailsSettings {
                    switch settings.recommendedProducts?.design {
                    case RecommendedProductsDesign.horizontal.rawValue:
                        return self.getRelatedProductsHorizontalCell(indexPath: indexPath, productModel: productModel)
                    case RecommendedProductsDesign.grid1.rawValue:
                        return self.getRelatedProductsGrid1Cell(indexPath: indexPath, productModel: productModel)
                    case RecommendedProductsDesign.grid2.rawValue:
                        return self.getRelatedProductsGrid2Cell(indexPath: indexPath, productModel: productModel)
                    default:
                        return UITableViewCell()
                    }
                }
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
}

// MARK: TableView Delegate
extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let settings = self.viewModel.productDetailsSettings {
            if settings.recommendedProducts?.isActive ?? false {
                return 4
            }
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let productModel = viewModel.productModel else {
            if isLoadingShimmer {
                switch section {
                case ProductDetailsSection.variants.rawValue:
                    return 3
                default:
                    return 1
                }
            }
            return 1
        }
        
        switch section {
        case ProductDetailsSection.variants.rawValue:
            return productModel.options?.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return getCellForSection(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoadingShimmer {
            return UITableView.automaticDimension
        }
        switch indexPath.section {
//        case ProductDetailsSection.slider.rawValue:
        case ProductDetailsSection.quantity.rawValue:
            if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
                if settings.quantityPosition == ProductDetailsQuantityPosition.bottom.rawValue {
                    return 0
                }
            }
        default:
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
}
