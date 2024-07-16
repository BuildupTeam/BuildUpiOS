//
//  ProfileViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import Foundation
import UIKit

enum ProfileCells: Int {
    case header = 0
    case editProfile
    case savedAddreses
    case wishlist
    case language
    case deleteAccount
    case logout
}

// MARK: Register TableView Cells
extension ProfileViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: ProfileHeaderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProfileTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProfileTableViewCell.identifier)
    }
}

// MARK: - Get Cells
extension ProfileViewController {
    private func getProfileHeaderTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileHeaderTableViewCell.identifier,
            for: indexPath) as? ProfileHeaderTableViewCell
        else { return UITableViewCell() }
        
        cell.userModel = self.viewModel.userModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProfileTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath) as? ProfileTableViewCell
        else { return UITableViewCell() }
        
        switch indexPath.row {
        case ProfileCells.editProfile.rawValue:
            cell.setupEditAccount()
        case ProfileCells.savedAddreses.rawValue:
            cell.setupSavedAddresses()
        case ProfileCells.wishlist.rawValue:
            cell.setupWishList()
        case ProfileCells.language.rawValue:
            cell.setupLanguage()
        case ProfileCells.deleteAccount.rawValue:
            cell.setupDeleteAccount()
        case ProfileCells.logout.rawValue:
            cell.setupLogout()
        default:
            return cell
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: Dynamic Components
extension ProfileViewController {
    func getCellForRow(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ProfileCells.header.rawValue:
            return self.getProfileHeaderTableViewCell(indexPath: indexPath)
        case ProfileCells.editProfile.rawValue:
            return self.getProfileTableViewCell(indexPath: indexPath)
        case ProfileCells.savedAddreses.rawValue:
            return self.getProfileTableViewCell(indexPath: indexPath)
        case ProfileCells.wishlist.rawValue:
            return self.getProfileTableViewCell(indexPath: indexPath)
        case ProfileCells.language.rawValue:
            return self.getProfileTableViewCell(indexPath: indexPath)
        case ProfileCells.deleteAccount.rawValue:
            return self.getProfileTableViewCell(indexPath: indexPath)
        case ProfileCells.logout.rawValue:
            return self.getProfileTableViewCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
}

// MARK: TableView Delegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCellForRow(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case ProfileCells.header.rawValue:
            if CachingService.getUser() != nil {
                return UITableView.automaticDimension
            } else {
                return 200
            }
        case ProfileCells.editProfile.rawValue:
            if CachingService.getUser() != nil {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        case ProfileCells.savedAddreses.rawValue:
            if CachingService.getUser() != nil {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        case ProfileCells.wishlist.rawValue:
            if CachingService.getUser() != nil {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        case ProfileCells.language.rawValue:
            return UITableView.automaticDimension
        case ProfileCells.deleteAccount.rawValue:
            if CachingService.getUser() != nil {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        case ProfileCells.logout.rawValue:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case ProfileCells.editProfile.rawValue:
            self.openEditProfile()
        case ProfileCells.savedAddreses.rawValue:
            self.openAddresses()
        case ProfileCells.wishlist.rawValue:
            self.openWishList()
        case ProfileCells.language.rawValue:
            self.openLanguagesBottomSheet()
        case ProfileCells.deleteAccount.rawValue:
            self.showDeleteAccountPopup()
        case ProfileCells.logout.rawValue:
            self.logoutAction()
        default:
            return
        }
    }
}
