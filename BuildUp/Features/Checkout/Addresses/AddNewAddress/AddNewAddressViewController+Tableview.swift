//
//  AddNewAddressViewController+Tableview.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/11/2023.
//

import Foundation
import UIKit

// MARK: Register TableView Cells
extension AddNewAddressViewController {
    
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: AddNewAddressCountryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddNewAddressCountryTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: AddNewAddressCityTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddNewAddressCityTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: AddNewAddressDetailsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddNewAddressDetailsTableViewCell.identifier)
    }
}

// MARK: TableView Delegate
extension AddNewAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case AddNewAddressCells.country.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddNewAddressCountryTableViewCell.identifier,
                for: indexPath) as? AddNewAddressCountryTableViewCell
            else { return UITableViewCell() }
            
            cell.countryModel = countryModel
            
            cell.selectionStyle = .none
            return cell
        case AddNewAddressCells.city.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddNewAddressCityTableViewCell.identifier,
                for: indexPath) as? AddNewAddressCityTableViewCell
            else { return UITableViewCell() }
            
            cell.cityModel = cityModel
            
            cell.selectionStyle = .none
            return cell
        case AddNewAddressCells.address.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddNewAddressDetailsTableViewCell.identifier,
                for: indexPath) as? AddNewAddressDetailsTableViewCell
            else { return UITableViewCell() }
            
            cell.delegate = self
            cell.detailedAddress = self.detailedAddress
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case AddNewAddressCells.country.rawValue:
            openCountriesList()
        case AddNewAddressCells.city.rawValue:
            openCitiesList()
        default: 
            return
        }
    }
}
