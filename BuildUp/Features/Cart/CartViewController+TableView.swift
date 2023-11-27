//
//  CartViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import UIKit

enum CartCells: Int {
    case summeryUp = 0
    case products
    case summeryDown
}

enum CartSummeryPosition: String {
    case upper = "upper"
    case down = "bottom"
}

enum CartProductDesign: String {
    case productCard1 = "product-card-1"
    case productCard2 = "product-card-2"
    case productCard3 = "product-card-3"
}

enum CartCheckoutButtonDesign: String {
    case checkoutButton1 = "button-1"
    case checkoutButton2 = "button-2"
    case checkoutButton3 = "button-3"
}

// MARK: Register TableView Cells
extension CartViewController {
    
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CartProductList1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CartProductList1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CartProductList2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CartProductList2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CartProductList3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CartProductList3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CartSummeryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CartSummeryTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerCartTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerCartTableViewCell.identifier)
    }
}

// MARK: Get Cart Cells
extension CartViewController {
    private func getShimmerCartTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerCartTableViewCell.identifier,
            for: indexPath) as? ShimmerCartTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCartProductList1TableViewCell(productModel: ProductModel, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CartProductList1TableViewCell.identifier,
            for: indexPath) as? CartProductList1TableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = productModel
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCartProductList2TableViewCell(productModel: ProductModel, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CartProductList2TableViewCell.identifier,
            for: indexPath) as? CartProductList2TableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = productModel
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCartProductList3TableViewCell(productModel: ProductModel, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CartProductList3TableViewCell.identifier,
            for: indexPath) as? CartProductList3TableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = productModel
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCartSummeryTableViewCell(cartModel: CartModel, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CartSummeryTableViewCell.identifier,
            for: indexPath) as? CartSummeryTableViewCell
        else { return UITableViewCell() }
        
        cell.cartModel = cartModel
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: TableView Delegate && DataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return self.viewModel.cartModel?.products?.count ?? 10
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            return getShimmerCartTableViewCell(indexPath: indexPath)
        }
        
        guard let cartModel = viewModel.cartModel else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            return getCartSummeryTableViewCell(cartModel: cartModel, indexPath: indexPath)
        case 1:
            guard let products = cartModel.products else {
                return UITableViewCell()
            }
            
            if let settings = viewModel.cartSettings {
                switch settings.productCartDesign {
                case CartProductDesign.productCard1.rawValue:
                    return getCartProductList1TableViewCell(productModel: products[indexPath.row], indexPath: indexPath)
                case CartProductDesign.productCard2.rawValue:
                    return getCartProductList2TableViewCell(productModel: products[indexPath.row], indexPath: indexPath)
                case CartProductDesign.productCard3.rawValue:
                    return getCartProductList3TableViewCell(productModel: products[indexPath.row], indexPath: indexPath)
                default:
                    return UITableViewCell()
                }
            }
        case 2:
            return getCartSummeryTableViewCell(cartModel: cartModel, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoadingShimmer {
            return 208
        }
        switch indexPath.section {
        case 0:
            if let settings = viewModel.cartSettings {
                if !(settings.cartSummaryDesign?.isActive ?? false) {
                    return 0
                }
                switch settings.cartSummaryDesign?.position {
                case CartSummeryPosition.upper.rawValue:
                    return UITableView.automaticDimension
                default:
                    return 0
                }
            }
        case 1:
            return UITableView.automaticDimension
        case 2:
            if let settings = viewModel.cartSettings {
                if !(settings.cartSummaryDesign?.isActive ?? false) {
                    return 0
                }
                switch settings.cartSummaryDesign?.position {
                case CartSummeryPosition.down.rawValue:
                    return UITableView.automaticDimension
                default:
                    return 0
                }
            }
        default:
            return 0
        }
        return 0
    }
}
