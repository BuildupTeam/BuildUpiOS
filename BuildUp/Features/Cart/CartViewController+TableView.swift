//
//  CartViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import UIKit

enum CartProductDesign: String {
    case productCard1 = "product-card-1"
    case productCard2 = "product-card-2"
    case productCard3 = "product-card-3"
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
    }
}

// MARK: Get Cart Cells
extension CartViewController {
    
}
