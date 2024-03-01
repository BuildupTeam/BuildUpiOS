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
    var refreshControl = UIRefreshControl()
    
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
        setupResponse()
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
    
    private func addRefreshControl() {
        self.refreshControl.removeFromSuperview()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
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
    
    @objc
    private func refreshData() {
        addFeedbackGenerator()
        viewModel.page = 1
        viewModel.perPage = 20
        viewModel.cursor = nil
        getOrders()
    }

}

// MARK: - TableView Delegate && DataSource
extension CurrentOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoadingShimmer {
            return 10
        }
        return self.viewModel.orders.count
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
            
            cell.orderModel = self.viewModel.orders[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.orders.count - 1) &&
            (viewModel.orders.count >= viewModel.perPage) {
            if !isReloadingTableView {
                if viewModel.responseModel?.pagination?.cursorMeta?.nextCursor != nil {
                    self.loadMoreOrders()
                    addSpinnerToTableView()
                }
            } else {
                isReloadingTableView = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderModel = self.viewModel.orders[indexPath.row]
        let orderDetailsVC = Coordinator.Controllers.createOrderDetailsViewController(orderModel: orderModel)
        self.navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
}

// MARK: - Requests & Responses
extension CurrentOrdersViewController {
    private func getOrders() {
        self.viewModel.getOrders(completed: 1)
    }
    
    func loadMoreOrders() {
        viewModel.page += 1
        getOrders()
    }
    
    private func setupResponse() {
        ordersResponse()
        loadMoreOrdersResponse()
    }
    
    private func ordersResponse() {
        self.viewModel.onOrders = { [weak self]() in
            guard let `self` = self else { return }
            self.tableView.refreshControl?.endRefreshing()
            self.addRefreshControl()

            if self.viewModel.orders.isEmpty {
                self.setupEmptyView(screenType: .emptyScreen)
            } else {
                self.removeBackgroundViews()
            }
            self.stopShimmerOn(tableView: self.tableView)
            self.reloadTableViewData()
            self.isReloadingTableView = false            
        }
    }
    
    private func loadMoreOrdersResponse() {
        viewModel.onLoadMoreOrders = { [weak self] () in
            guard let `self` = self else { return }
            self.tableView.tableFooterView = nil
            self.reloadTableViewData()
            self.isReloadingTableView = false
        }
    }
}
