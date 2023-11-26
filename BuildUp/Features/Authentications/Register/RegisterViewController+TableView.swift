//
//  RegisterViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import UIKit

enum RegisterCells: Int {
    case name = 0
    case phone
    case email
    case password
    case confirmPassword
    
}

// MARK: Register TableView Cells
extension RegisterViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: RegisterEmailTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterEmailTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterPhoneTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterPhoneTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterNameTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterNameTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterPasswordTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterPasswordTableViewCell.identifier)
    }
}

// MARK: Get Cells
extension RegisterViewController {
    private func getNameCell(model: RegisterModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterNameTableViewCell.identifier) as? RegisterNameTableViewCell
        else { return UITableViewCell() }
        
        cell.registerModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getEmailCell(model: RegisterModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterEmailTableViewCell.identifier) as? RegisterEmailTableViewCell
        else { return UITableViewCell() }
        
        cell.registerModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getPhoneCell(model: RegisterModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterPhoneTableViewCell.identifier) as? RegisterPhoneTableViewCell
        else { return UITableViewCell() }
        
        cell.registerModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getPasswordCell(model: RegisterModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterPasswordTableViewCell.identifier) as? RegisterPasswordTableViewCell
        else { return UITableViewCell() }
        
        cell.registerModel = model
        cell.delegate = self
        cell.setupPassword()
        cell.selectionStyle = .none
        return cell
    }
    
    private func getConfirmPasswordCell(model: RegisterModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterPasswordTableViewCell.identifier) as? RegisterPasswordTableViewCell
        else { return UITableViewCell() }
        
        cell.registerModel = model
        cell.delegate = self
        cell.setupConfirmPassword()
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate && DataSource
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case RegisterCells.name.rawValue:
            return getNameCell(model: self.registerModel)
        case RegisterCells.email.rawValue:
            return getEmailCell(model: self.registerModel)
        case RegisterCells.phone.rawValue:
            return getPhoneCell(model: self.registerModel)
        case RegisterCells.password.rawValue:
            return getPasswordCell(model: self.registerModel)
        case RegisterCells.confirmPassword.rawValue:
            return getConfirmPasswordCell(model: self.registerModel)
        default:
            return UITableViewCell()
        }
    }
}
