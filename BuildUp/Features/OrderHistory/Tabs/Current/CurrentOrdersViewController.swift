//
//  CurrentOrdersViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import UIKit

class CurrentOrdersViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: OrderHistoryViewModel!
    
    // MARK: - init methods
    var isReloadingTableView = false
    
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: OrderHistoryViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        ordersResponse()
        getOrders()
        startShimmerOn(tableView: tableView)
    }
    
    private func setupView() {
        registerTableViewCells()
        isLoadingShimmer = true
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CurrentOrderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CurrentOrderTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerOrderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerOrderTableViewCell.identifier)
    }
    
    private func setupEmptyView() {
        removeBackgroundViews()
        let emptyNib = EmptyScreenView.instantiateFromNib()
        emptyNib.frame = tableView.backgroundView?.frame ?? CGRect()
        emptyNib.title = L10n.EmptyScreen.noData
//        emptyNib.emptyImage = Asset.icEmptyViewSearch.image
        emptyNib.showButton = false
        tableView.backgroundView = emptyNib
    }
    
    private func removeBackgroundViews() {
        tableView.backgroundView = nil
    }

}

// MARK: - TableView Delegate && DataSource
extension CurrentOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orders?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerOrderTableViewCell.identifier,
                for: indexPath) as? ShimmerOrderTableViewCell
            else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrentOrderTableViewCell.identifier,
            for: indexPath) as? CurrentOrderTableViewCell
        else { return UITableViewCell() }
        
        cell.orderModel = self.viewModel.orders?[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Requests & Responses
extension CurrentOrdersViewController {
    private func getOrders() {
        self.viewModel.getOrders(completed: 1)
    }
    
    private func ordersResponse() {
        self.viewModel.onOrders = { [weak self]() in
            guard let `self` = self else { return }
            if viewModel.orders?.isEmpty ?? false {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.tableView.reloadData()
            self.stopShimmerOn(tableView: self.tableView)
        }
    }
}
