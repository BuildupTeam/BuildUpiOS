//
//  CategoriesTabViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import Foundation
import UIKit

extension CategoriesTabViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CategoryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
}

extension CategoriesTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.identifier,
            for: indexPath) as? CategoryTableViewCell
        else { return UITableViewCell() }
        
        cell.categoryModel = self.viewModel.categories[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
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
        let categoryModel = viewModel.categories[indexPath.row]
        for category in viewModel.categories {
            category.isSelected = false
        }
        
        categoryModel.isSelected = true
        viewModel.categories[indexPath.row] = categoryModel
        self.isLoadingShimmer = true
        startShimmerOn(collectionView: collectionView)
        
        self.viewModel.page = 1
        self.viewModel.categoryModel = categoryModel
        self.tableView.reloadData()
    }
}
