//
//  CheckoutViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 03/04/2024.
//

import Foundation
import UIKit

enum CheckoutCells: Int {
    case name = 0
    case phone
    case payment
    case deliveryInfo
    case items
    case summery
}

extension CheckoutViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: RegisterPhoneTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterPhoneTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterNameTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterNameTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutShippingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutShippingTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutHeaderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutHeaderTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutAddAddressTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutAddAddressTableViewCell.identifier)
        
        self.tableView.register(
            UINib(nibName: CheckoutPaymentMethodsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutPaymentMethodsTableViewCell.identifier)
        
        self.tableView.register(
            UINib(nibName: CheckoutProductsListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutProductsListTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutSummaryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutSummaryTableViewCell.identifier)
    }
}

// MARK: Get Cells
extension CheckoutViewController {
    private func getSectionHeaderCell(section: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutHeaderTableViewCell.identifier) as? CheckoutHeaderTableViewCell
            else { return UITableViewCell() }
        
        cell.section = section
        cell.selectionStyle = .none
        return cell
    }
    
    private func getNameCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterNameTableViewCell.identifier,
            for: indexPath) as? RegisterNameTableViewCell
        else { return UITableViewCell() }
        
        cell.checkoutModel = self.checkoutModel
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    
    private func getPhoneCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterPhoneTableViewCell.identifier,
            for: indexPath) as? RegisterPhoneTableViewCell
        else { return UITableViewCell() }
        
        cell.checkoutModel = self.checkoutModel
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getAddressCell(model: AddressModel, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutShippingTableViewCell.identifier,
            for: indexPath) as? CheckoutShippingTableViewCell
        else { return UITableViewCell() }
        
        cell.checkoutModel = self.checkoutModel
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getAddNewAddressCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutAddAddressTableViewCell.identifier,
            for: indexPath) as? CheckoutAddAddressTableViewCell
        else { return UITableViewCell() }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getPaymentMethodCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutPaymentMethodsTableViewCell.identifier,
            for: indexPath) as? CheckoutPaymentMethodsTableViewCell
        else { return UITableViewCell() }
        
        cell.paymentMethods = self.viewModel.paymentMethods
        cell.delegate = self
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getSummeryCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutSummaryTableViewCell.identifier,
            for: indexPath) as? CheckoutSummaryTableViewCell
        else { return UITableViewCell() }
        
        cell.summaryModel = self.viewModel.summaryData?.summary
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductsCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutProductsListTableViewCell.identifier,
            for: indexPath) as? CheckoutProductsListTableViewCell
        else { return UITableViewCell() }
        
        cell.products = self.viewModel.summaryData?.products
        
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: TableView Delegate
extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(self.viewModel.paymentMethods?.isEmpty ?? false) && self.viewModel.summaryData != nil {
            if self.viewModel.addresses?.isEmpty ?? false {
                return 4
            }
            return 6
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CheckoutCells.name.rawValue:
            return self.getNameCell(indexPath: indexPath)
        case CheckoutCells.phone.rawValue:
            return self.getPhoneCell(indexPath: indexPath)
        case CheckoutCells.payment.rawValue:
            return self.getPaymentMethodCell(indexPath: indexPath)
        case CheckoutCells.deliveryInfo.rawValue:
            if let model = self.checkoutModel.address {
                return self.getAddressCell(model: model, indexPath: indexPath)
            } else {
                return getAddNewAddressCell(indexPath: indexPath)
            }
        case CheckoutCells.items.rawValue:
            return self.getProductsCell(indexPath: indexPath)
        case CheckoutCells.summery.rawValue:
            return self.getSummeryCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CheckoutCells.payment.rawValue:
            return CGFloat((self.viewModel.paymentMethods?.count ?? 0) * 65) + 60
        case CheckoutCells.items.rawValue:
            return CGFloat((self.viewModel.summaryData?.products?.count ?? 0) * 65) + 60
        default:
            return UITableView.automaticDimension
        }
    }
}
