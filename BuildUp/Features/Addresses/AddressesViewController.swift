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
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var confirmButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var addNewAddressContainerView: UIView!
    @IBOutlet private weak var addNewAddressLabel: UILabel!
    @IBOutlet private weak var plusImageView: UIImageView!

    var isReloadingTableView = false
    weak var delegate: AddressesDelegate?
    
    var viewModel: AddressesViewModel!
    var isCommingFromShipping = false
        
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.Login.Empty.navigation, style: .plain, target: nil, action: nil)
    }
}

// MARK: - private Functions
extension AddressesViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        deactivatConfirmButton()
        
        confirmButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        confirmButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        addNewAddressLabel.font = .appFont(ofSize: 14, weight: .medium)
        addNewAddressLabel.textColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "")
        
        plusImageView.image = Asset.icPlusCircle.image.withRenderingMode(.alwaysTemplate)
        plusImageView.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
         
        addNewAddressLabel.text = L10n.Checkout.addNewAddress

        addNewAddressContainerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        addNewAddressContainerView.layer.borderColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "").cgColor
        addNewAddressContainerView.layer.borderWidth = 1
        
        if isCommingFromShipping {
            confirmButton.setTitle(L10n.Checkout.confirm, for: .normal)
        } else {
            confirmButton.setTitle(L10n.Checkout.Addresses.setAsDefault, for: .normal)
        }
        
        ThemeManager.setCornerRadious(element: addNewAddressContainerView, radius: 8)
        ThemeManager.setCornerRadious(element: confirmButton, radius: 8)
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
        emptyNib.emptyImage = Asset.icNoOrders.image
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
    
    private func checkToActivateConfirmButton() {
        let isSelected = self.viewModel.addresses?.first(where: {$0.isDefault ?? false})
        if (isSelected != nil) {
            activateConfirmButton()
        } else {
            deactivatConfirmButton()
        }
    }
    
    private func activateConfirmButton() {
        confirmButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        confirmButton.isUserInteractionEnabled = true
    }
    
    private func deactivatConfirmButton() {
        confirmButton.backgroundColor = UIColor.dimmedButtonGray
        confirmButton.isUserInteractionEnabled = false
    }
}

// MARK: - Actions
extension AddressesViewController {
    @IBAction func confirmAction(_ sender: UIButton) {
        if isCommingFromShipping {
            if let model = self.viewModel.addresses?.first(where: {$0.isDefault ?? false}) {
                self.delegate?.addressTaped(addressModel: model)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.showLoading()
            self.viewModel.setDefaultAddress(adddressId: self.viewModel.addresses?.first(where: {$0.isDefault ?? false})?.id ?? 0)
        }
    }
    
    @IBAction func addNewAddressAction(_ sender: UIButton) {
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
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddressTableViewCell.identifier,
                for: indexPath) as? AddressTableViewCell
            else { return UITableViewCell() }
            
            cell.delegate = self
            cell.addressModel = self.viewModel.addresses?[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addresses = self.viewModel.addresses {
            for address in addresses {
                address.isDefault = false
            }
            if let model = self.viewModel.addresses?[indexPath.row] {
                model.isDefault = true
                self.viewModel.addresses?[indexPath.row] = model
                self.tableView.reloadData()
            }
            
            checkToActivateConfirmButton()
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
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
    private func defaultAddressResponse() {
        self.viewModel.onDefaultAddress = { [weak self] (message) in
            guard let `self` = self else { return }
            self.hideLoading()
            if let message = message {
                self.showSuccessMessage(message: message)
            }
//            if let address = self.viewModel.addresses?.filter({ ($0.isDefault ?? false) == true }).first {
//                self.delegate?.addressTaped(addressModel: address)
//                self.navigationController?.popViewController(animated: true)
//            }
        }
    }
}
