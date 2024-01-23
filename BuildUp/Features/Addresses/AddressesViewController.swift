//
//  AddressesViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

protocol AddressesDelegate: AnyObject {
    func addressTaped(addressModel: AddressModel)
}

class AddressesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addAddressButton: UIButton!

    var isReloadingTableView = false
    weak var delegate: AddressesDelegate?
    
    var viewModel: AddressesViewModel!
        
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: AddressesViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addressesResponse()
        defaultAddressResponse()
        startShimmerOn(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = L10n.Checkout.addresses
        getAddresses()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
}

// MARK: - private Functions
extension AddressesViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        
        addAddressButton.layer.masksToBounds = true
        addAddressButton.layer.cornerRadius = 8
        addAddressButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        addAddressButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        addAddressButton.setTitle(L10n.Checkout.addNewAddress, for: .normal)
        addAddressButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: AddressTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddressTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerAddressTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerAddressTableViewCell.identifier)
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

    private func getAddresses() {
        self.viewModel.getAddresses()
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
}

// MARK: - Actions
extension AddressesViewController {
    @IBAction func addddressAction(_ sender: UIButton) {
        let addAddressVC = Coordinator.Controllers.createAddNewAddressViewController()
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
}

// MARK: - TableView Delegate && DataSource
extension AddressesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.addresses?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerAddressTableViewCell.identifier,
                for: indexPath) as? ShimmerAddressTableViewCell
            else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AddressTableViewCell.identifier,
            for: indexPath) as? AddressTableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.addressModel = self.viewModel.addresses?[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addresses = self.viewModel.addresses {
            for address in addresses {
                address.isSelected = false
            }
            
            if let model = self.viewModel.addresses?[indexPath.row] {
                model.isSelected = true
                self.viewModel.addresses?[indexPath.row] = model
                self.showLoading()
                self.viewModel.setDefaultAddress(adddressId: model.id ?? 0)
            }
        }
    }
}

// MARK: - AddressCellDelegate
extension AddressesViewController: AddressCellDelegate {
    func editButtonClicked(addressModel: AddressModel) {
        let addAddressVC = Coordinator.Controllers.createAddNewAddressViewController()
        addAddressVC.addressModel = addressModel
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
}

// MARK: - Responses
extension AddressesViewController {
    private func addressesResponse() {
        self.viewModel.onAddresses = { [weak self]() in
            guard let `self` = self else { return }
            if self.viewModel.addresses?.isEmpty ?? false {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.tableView.reloadData()
            self.stopShimmerOn(tableView: self.tableView)
        }
    }
    
    private func defaultAddressResponse() {
        self.viewModel.onDefaultAddress = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            if let address = self.viewModel.addresses?.filter({ $0.isSelected == true }).first {
                self.delegate?.addressTaped(addressModel: address)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
