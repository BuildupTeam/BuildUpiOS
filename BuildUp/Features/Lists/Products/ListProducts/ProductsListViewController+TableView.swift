//
//  ProductListViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import UIKit

enum ProductListDesign: String {
    case list1 = "product-vertical-list-1"
    case list2 = "product-vertical-list-2"
    case list3 = "product-vertical-list-3"
    case grid1 = "product-vertical-grid-1"
    case grid2 = "product-vertical-grid-2"
    case grid3 = "product-vertical-grid-3"
    case grid4 = "product-vertical-grid-4"
    case grid5 = "product-vertical-grid-5"
}

// MARK: Register TableView Cells
extension ProductsListViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: ProductVerticalList1InnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList1InnerTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalList2InnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList2InnerTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalList3InnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList3InnerTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerProductVerticalListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductVerticalListTableViewCell.identifier)
    }
}

// MARK: - Get Cells
extension ProductsListViewController {
    private func getShimmerCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerProductVerticalListTableViewCell.identifier,
            for: indexPath) as? ShimmerProductVerticalListTableViewCell
        else { return UITableViewCell() }
        
        cell.isExclusiveTouch = true
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalList1TableViewCell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList1InnerTableViewCell.identifier,
            for: indexPath) as? ProductVerticalList1InnerTableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalList2TableViewCell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList2InnerTableViewCell.identifier,
            for: indexPath) as? ProductVerticalList2InnerTableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalList3TableViewCell(indexPath: IndexPath, productModel: ProductModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList3InnerTableViewCell.identifier,
            for: indexPath) as? ProductVerticalList3InnerTableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = productModel
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: Dynamic Components
extension ProductsListViewController {
    func getCellForRow(indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            return self.getShimmerCell(indexPath: indexPath)
        } else {
            let productModel = viewModel.products[indexPath.row]
            
            if let settings = viewModel.productListSettings {
                switch settings.list {
                case ProductListDesign.list1.rawValue:
                    return self.getProductVerticalList1TableViewCell(indexPath: indexPath, productModel: productModel)
                case ProductListDesign.list2.rawValue:
                    return self.getProductVerticalList2TableViewCell(indexPath: indexPath, productModel: productModel)
                case ProductListDesign.list3.rawValue:
                    return self.getProductVerticalList3TableViewCell(indexPath: indexPath, productModel: productModel)
                default:
                    return UITableViewCell()
                }
            }
        }
        return UITableViewCell()
    }
}


// MARK: TableView Delegate
extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.products.isEmpty {
            return 10
        }
        return self.viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCellForRow(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.products.count - 1) &&
            (viewModel.products.count >= viewModel.perPage) {
            if !isReloadingTableView {
                if viewModel.products.count < viewModel.totalCount {
                    self.loadMoreProducts()
                    addSpinnerToTableView()
                }
            } else {
                isReloadingTableView = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productModel = viewModel.products[indexPath.row]
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController(componentModel: self.componentModel)
        detailsVC.productModel = productModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
