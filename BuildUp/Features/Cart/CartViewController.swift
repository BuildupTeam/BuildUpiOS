//
//  CartViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import UIKit

class CartViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var isReloadingTableView = false
    var viewModel: CartViewModel!
    
    override  var prefersBottomBarHidden: Bool? { return true }
    
    init(viewModel: CartViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupResponses()
        getCart()
        startShimmerOn(tableView: tableView)
    }

}

// MARK: - Private Func
extension CartViewController {
    private func setupView() {
        isLoadingShimmer = true
        fillData()
        registerTableViewCells()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
    }
    
    private func fillData() {
        
    }
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    func addSpinnerToTableView() {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 44)
        spinner.hidesWhenStopped = false
        spinner.color = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        spinner.startAnimating()
        tableView.tableFooterView = spinner
    }
    
    private func removeBackgroundViews() {
        tableView.backgroundView = nil
    }
}

// MARK: - Requests
extension CartViewController {
    private func getCart() {
        viewModel.getCart()
    }
    private func setupResponses() {
        cartResponse()
    }
}

// MARK: - Responses
extension CartViewController {
    private func cartResponse() {
        viewModel.onCart = {[weak self] () in
            guard let `self` = self else { return }
            self.reloadTableViewData()
            self.isReloadingTableView = false
            self.stopShimmerOn(tableView: self.tableView)
        }
    }
}
