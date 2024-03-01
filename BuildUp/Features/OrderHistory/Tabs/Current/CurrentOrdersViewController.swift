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
        ordersResponse()
        setupView()
    }
    
    private func setupView() {
        registerTableViewCells()

        if CachingService.getUser() != nil {
            isLoadingShimmer = true
            getOrders()
            startShimmerOn(tableView: tableView)
        } else {
            isLoadingShimmer = false
            setupEmptyView(screenType: .loginFirst)
        }
        
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
    
    private func setupEmptyView(screenType: EmptyScreenType) {
        removeBackgroundViews()
        let emptyNib = EmptyScreenView.instantiateFromNib()
        emptyNib.frame = tableView.backgroundView?.frame ?? CGRect()
        emptyNib.screenType = screenType
        if screenType == .emptyScreen {
            emptyNib.title = L10n.EmptyScreen.noOrders
            emptyNib.emptyImage = Asset.icNoOrders.image
        } else if screenType == .loginFirst {
            emptyNib.emptyImage = Asset.icLogin.image
            emptyNib.title = L10n.Popups.loginMsg
        }
        
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
        if isLoadingShimmer {
            return 10
        }
        return self.viewModel.orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerOrderTableViewCell.identifier,
                for: indexPath) as? ShimmerOrderTableViewCell
            else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CurrentOrderTableViewCell.identifier,
                for: indexPath) as? CurrentOrderTableViewCell
            else { return UITableViewCell() }
            
            if let model = self.viewModel.orders?[indexPath.row] {
                cell.orderModel = model
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let orderModel = self.viewModel.orders?[indexPath.row] {
            let orderDetailsVC = Coordinator.Controllers.createOrderDetailsViewController(orderModel: orderModel)
            self.navigationController?.pushViewController(orderDetailsVC, animated: true)
        }
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
            if self.viewModel.orders?.isEmpty ?? false {
                self.setupEmptyView(screenType: .emptyScreen)
            } else {
                self.removeBackgroundViews()
            }
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
}
