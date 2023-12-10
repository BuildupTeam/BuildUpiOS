//
//  EditProfileViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation
import UIKit

enum EditProfileCells: Int {
    case userImage = 0
    case name
    case phone
    case email
    
}

// MARK: Register TableView Cells
extension EditProfileViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: UpdateUserImageTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: UpdateUserImageTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterEmailTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterEmailTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterPhoneTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterPhoneTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterNameTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterNameTableViewCell.identifier)
    }
}

// MARK: Get Cells
extension EditProfileViewController {
    private func getNameCell(model: EditProfileModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterNameTableViewCell.identifier) as? RegisterNameTableViewCell
        else { return UITableViewCell() }
        
        cell.editProfileModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getEmailCell(model: EditProfileModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterEmailTableViewCell.identifier) as? RegisterEmailTableViewCell
        else { return UITableViewCell() }
        
        cell.editProfileModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getPhoneCell(model: EditProfileModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterPhoneTableViewCell.identifier) as? RegisterPhoneTableViewCell
        else { return UITableViewCell() }
        
        cell.editProfileModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getUserImageCell(model: EditProfileModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UpdateUserImageTableViewCell.identifier) as? UpdateUserImageTableViewCell
        else { return UITableViewCell() }
        
        cell.editProfileModel = model
//        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate && DataSource
extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case EditProfileCells.userImage.rawValue:
            return getUserImageCell(model: self.editProfileModel)
        case EditProfileCells.name.rawValue:
            return getNameCell(model: self.editProfileModel)
        case EditProfileCells.email.rawValue:
            return getEmailCell(model: self.editProfileModel)
        case EditProfileCells.phone.rawValue:
            return getPhoneCell(model: self.editProfileModel)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case EditProfileCells.userImage.rawValue:
            self.addPhotoAlertView()
        default:
            return
        }
    }
}
