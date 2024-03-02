//
//  HomeViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit
//import Foundation
import ObjectMapper
import CryptoKit
import CryptoSwift
import CommonCrypto

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!

    var isReloadingTableView = false
    var refreshControl = UIRefreshControl()
    
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistanceManager.setLatestViewController(Constant.ControllerName.home)
        setupView()
        startShimmer()
        setupResponse()
        getHomeData()
        scrollToFirstRow()
        getFirebaseToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "
    }
    
    func scrollToFirstRow() {
//        if viewModel.homeData.isAllDataValid {
            tableView.scrollToTopRow()
//            getHomeData()
//        }
    }
}

// MARK: - SetupUI
extension HomeViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()       
        setupNavigationBar()
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    private func setupNavigationBar() {
        
        let logoView = HomeLogoView.instantiateFromNib()
        logoView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        logoView.setupView()

        logoView.backgroundColor = .clear
        self.navigationItem.titleView?.tintColor = .clear

        self.navigationItem.titleView = logoView
        
        let scanItem = UIBarButtonItem(
            image: Asset.icQrcodeScan.image,
            style: .plain,
            target: self,
            action: #selector(scanAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = scanItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func startShimmer() {
        startShimmerOn(tableView: tableView)
    }
    
    private func addRefreshControl() {
        self.refreshControl.removeFromSuperview()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func getFirebaseToken() {
        viewModel.getFirebaseToken()
    }
    
    private func showLoginPopup() {
        let loginVC = LoginPopupViewController()
        loginVC.delegate = self
        self.presentPanModal(loginVC)
    }
}

// MARK: - Popup Delegate
extension HomeViewController: LoginPopupProtocol {
    func loginButtonClicked() {
        LauncherViewController.showLoginView(fromViewController: nil)
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    func notificationAction(sender: UIBarButtonItem) {
        PersistanceManager.setLatestViewController(Constant.ControllerName.subdomin)
        LauncherViewController.showSubdomainScreen(fromViewController: nil)
    }
    
    @objc
    func scanAction(sender: UIBarButtonItem) {
         PersistanceManager.setLatestViewController(Constant.ControllerName.subdomin)
         LauncherViewController.showSubdomainScreen(fromViewController: nil)
    }
    
    
//    func decodeMessage(config: String) throws -> PaymentConfig? {
//        guard let decodedData = Data(base64Encoded: config) else {
//            throw NSError(domain: "Invalid Base64 encoding", code: 0, userInfo: nil)
//        }
//        
//        // Extract IV (first 16 bytes), key, and encrypted data
//        let iv = decodedData.prefix(16)
//        let keyData = decodedData.suffix(32)
//        let encryptedData = decodedData.subdata(in: 16..<decodedData.count - 32)
//        
//        // Create a SymmetricKey
//        let key = SymmetricKey(data: keyData)
//        
//        // Assuming you have the tag as well, or it's appended at the end of the encrypted data.
//        // If not, you need to adjust according to your data format.
//        // For demonstration, assuming no tag is appended:
//        let tag = Data() // Use an actual tag if available
//        
//        // Create a SealedBox for AES.GCM
//        guard let nonce = try? AES.GCM.Nonce(data: iv) else {
//            throw NSError(domain: "Invalid nonce", code: 0, userInfo: nil)
//        }
//        
//        do {
//            let sealedBox = try AES.GCM.SealedBox(nonce: nonce, ciphertext: encryptedData, tag: tag)
//            let decryptedData = try AES.GCM.open(sealedBox, using: key)
//            
//            // Assuming the decrypted data is a JSON string that can be decoded into a PaymentConfig object
//            let decoder = JSONDecoder()
//            let paymentConfig = try decoder.decode(PaymentConfig.self, from: decryptedData)
//            return paymentConfig
//        } catch(let error) {
//            print(error)
//        }
//        
//        // Decrypt the message
//        return nil
//    }
    
    func decryptMessageWithCommonCrypto(config: String) -> PaymentConfig? {
        guard let decodedData = Data(base64Encoded: config),
              decodedData.count > 48 else { // Ensuring there's enough data for IV, key, and ciphertext
            return nil
        }

        let iv = Array(decodedData.prefix(16))
        let keyData = Array(decodedData.suffix(32))
        let encryptedData = Array(decodedData.subdata(in: 16..<decodedData.count - 32))

        var decryptedData = Array<UInt8>(repeating: 0, count: encryptedData.count)
        var numBytesDecrypted: size_t = 0

        let status = CCCrypt(CCOperation(kCCDecrypt),
                             CCAlgorithm(kCCAlgorithmAES),
                             CCOptions(kCCOptionPKCS7Padding),
                             keyData, keyData.count,
                             iv,
                             encryptedData, encryptedData.count,
                             &decryptedData, decryptedData.count,
                             &numBytesDecrypted)

        guard status == kCCSuccess else {
            print("Decryption failed with status: \(status)")
            return nil
        }
        
        let outputData = Data(decryptedData[0..<numBytesDecrypted])
        
        if let returnData = String(data: outputData, encoding: .utf8) {
            
        }
        
        if let jsonResponse = String(data: Data(outputData), encoding: .utf8) {
            let paymentConfigResponse = Mapper<PaymentConfig>().map(JSONObject: jsonResponse)
            return paymentConfigResponse
            //try JSONDecoder().decode(PaymentConfig.self, from: json.data(using: .utf8)!)
        }
        
        return nil //String(data: outputData, encoding: .utf8)
    }
    
    //    func decodeMessage(config: String) {
    //        let decodedData = Data(base64Encoded: config)!
    //
    //                // Extract IV (first 16 bytes), key, and encrypted data
    //                let iv = decodedData.prefix(16)
    //                let keyData = decodedData.suffix(32)
    //                let encryptedData = decodedData.subdata(in: 16..<decodedData.count - 32)
    //
    //                // Create a SymmetricKey
    //                let key = SymmetricKey(data: keyData)
    //
    //                // Decrypt the message
    //                let cipher = try AES.GCM.open(encryptedData, using: key, nonce: AES.GCM.Nonce(data: iv))
    //    }
//
//    func decryptMsg(config: String) -> PaymentConfig? {
//        guard let decodedData = Data(base64Encoded: config) else { return nil }
//        let iv = decodedData.prefix(16)
//        let keyData = decodedData.suffix(32)
//        let encryptedData = decodedData.subdata(in: 16..<decodedData.count - 32)
//
//        var decryptedData = Data(count: encryptedData.count)
//        var numBytesDecrypted: size_t = 0
//
//        let status = keyData.withUnsafeBytes { keyBytes -> CCCryptorStatus in
//            let keyPointer = keyBytes.bindMemory(to: UInt8.self).baseAddress!
//            
//            return iv.withUnsafeBytes { ivBytes -> CCCryptorStatus in
//                let ivPointer = ivBytes.bindMemory(to: UInt8.self).baseAddress!
//                
//                return encryptedData.withUnsafeBytes { encryptedBytes -> CCCryptorStatus in
//                    let encryptedPointer = encryptedBytes.bindMemory(to: UInt8.self).baseAddress!
//                    
//                    decryptedData = decryptedData.withUnsafeMutableBytes { decryptedBytes -> CCCryptorStatus in
//                        let decryptedPointer = decryptedBytes.bindMemory(to: UInt8.self).baseAddress!
//                        
//                        return CCCrypt(CCOperation(kCCDecrypt),
//                                       CCAlgorithm(kCCAlgorithmAES),
//                                       CCOptions(kCCModeCTR),
//                                       keyPointer, keyData.count,
//                                       ivPointer,
//                                       encryptedPointer, encryptedData.count,
//                                       decryptedPointer, decryptedData.count,
//                                       &numBytesDecrypted)
//                    }
//                    
//                    return decryptedData
//                }
//            }
//        }
//
//        guard status == kCCSuccess, numBytesDecrypted > 0 else { return nil }
//        decryptedData.removeSubrange(numBytesDecrypted..<decryptedData.count)
//
//        do {
//            let paymentConfig = try JSONDecoder().decode(PaymentConfig.self, from: decryptedData)
//            return paymentConfig
//        } catch {
//            print("Decryption or JSON decoding failed with error: \(error)")
//            return nil
//        }
//    }
    
    @objc
    private func refreshData() {
        self.getHomeData()
    }
}
// MARK: - Requests
extension HomeViewController {
    
    private func getHomeData() {
        self.viewModel.getHomeTemplate()
        self.viewModel.getCachedThemeData()
     }
    
    private func setupResponse() {
        homeResponse()
        cartItemUpdatedResponse()
        favoriteProductUpdatedResponse()
    }
}

// MARK: - Responses
extension HomeViewController {
    
    private func homeResponse() {
        viewModel.onData = { [weak self] () in
            guard let `self` = self else { return }
            print("Normal Reload")
            self.containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
            self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
            
            self.hideLoading()
            self.tableView.refreshControl?.endRefreshing()
            self.addRefreshControl()
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
    private func cartItemUpdatedResponse() {
        ObservationService.carItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            //getProductsWithCartQuantity
            self.viewModel.updateAllHomeSectionsWithCartItems()
            self.tableView.reloadData()
        })
    }
    
    private func favoriteProductUpdatedResponse() {
        ObservationService.favItemUpdated.append({ [weak self] () in
            guard let `self` = self else { return }
            //getProductsWithCartQuantity
            self.viewModel.updateAllHomeSectionsWitFavoriteProducts()
            self.tableView.reloadData()
        })
    }
}

// MARK: - HomeProductsCellDelegate
extension HomeViewController: HomeProductsCellDelegate {
    func homeProductTapped(productModel: ProductModel?, componentModel: ComponentConfigurationModel?) {
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController(componentModel: componentModel)
        detailsVC.productModel = productModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - HomeCategoriesCellDelegate
extension HomeViewController: HomeCategoriesCellDelegate {
    func homeCategoryTapped(categoryModel: CategoryModel?, componentModel: ComponentConfigurationModel?) {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoryDetails.rawValue})?.settings {
            switch settings.productsList?.design {
            case ProductListDesign.list1.rawValue,
                ProductListDesign.list2.rawValue,
                ProductListDesign.list3.rawValue:
                let detailsVC = Coordinator.Controllers.createCategoryDetailsListViewController(categoryModel: categoryModel)
                detailsVC.categoryModel = categoryModel
                detailsVC.componentModel = componentModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            default:
                let detailsVC = Coordinator.Controllers.createCategoryDetailsGridViewController(categoryModel: categoryModel)
                detailsVC.categoryModel = categoryModel
                detailsVC.componentModel = componentModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }
}

// MARK: - HomeHeaderCellDelegate
extension HomeViewController: HomeHeaderCellDelegate {
    func seeAllButtonClicked(_ homeSectionModel: HomeSectionModel) {
        if let contentType = homeSectionModel.component?.contentType {
            switch contentType {
            case HomeContentType.products.rawValue:
                if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productList.rawValue})?.settings {
                    switch settings.list {
                    case ProductListDesign.list1.rawValue,
                        ProductListDesign.list2.rawValue,
                        ProductListDesign.list3.rawValue:
                        let detailsVC = Coordinator.Controllers.createProductListViewController(homeSectionModel: homeSectionModel)
                        detailsVC.componentModel = homeSectionModel.component
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    case ProductListDesign.grid1.rawValue,
                        ProductListDesign.grid2.rawValue,
                        ProductListDesign.grid3.rawValue,
                        ProductListDesign.grid4.rawValue,
                        ProductListDesign.grid5.rawValue:
                        let detailsVC = Coordinator.Controllers.createProductsGridViewController(homeSectionModel: homeSectionModel)
                        detailsVC.componentModel = homeSectionModel.component
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    default:
                        return
                    }
                }
            case HomeContentType.categories.rawValue:
                let detailsVC = Coordinator.Controllers.createCategoryListViewController(homeSectionModel: homeSectionModel)
                detailsVC.componentModel = homeSectionModel.component
                self.navigationController?.pushViewController(detailsVC, animated: true)
            default:
                return
            }
        }
    }
}

// MARK: - HomeHeaderCellDelegate
extension HomeViewController: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        if var products = self.viewModel.homeData.homeSections.first(where: { $0.component == homeSectionModel?.component })?.products {
            if let index = products.firstIndex(where: { $0.uuid == model.uuid }) {
                products[index].cartQuantity = model.cartQuantity
                self.viewModel.homeData.homeSections.first(where: { $0.component == homeSectionModel?.component })?.products = products
                
                self.tableView.reloadData()
            }
        }
    }
    
    func userShouldLoginFirst() {
        self.showLoginPopup()
    }
}

// MARK: - HomeHeaderCellDelegate
extension HomeViewController: ProductFavoriteDelegate {
    func productFavorite(model: ProductModel) {
        
    }
    
    func pleaseLoginFirst() {
        showLoginPopup()
    }
}
