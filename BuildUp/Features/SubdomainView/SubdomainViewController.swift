//
//  SubdomainViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 12/10/2023.
//

import UIKit
import AVFoundation

class SubdomainViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var scanTitleLabel: UILabel!
    @IBOutlet weak var scanContentLabel: UILabel!
    @IBOutlet weak var scanCodeButton: UIButton!
    
    var viewModel: SubdomainViewModel!
    
    // initialization and each time we need to scan a QRCode
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    init(viewModel: SubdomainViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistanceManager.setLatestViewController(Constant.ControllerName.subdomin)
        homeResponse()
        setupView()
    }
    
    private func setupView() {
        scanTitleLabel.font = .appFont(ofSize: 17, weight: .semiBold)
        scanContentLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        scanTitleLabel.textColor = UIColor.qrCodeTitleColor
        scanContentLabel.textColor = UIColor.qrCodeContentColor
        
        scanTitleLabel.text = L10n.QRCode.title
        scanContentLabel.text = L10n.QRCode.content
        
        scanCodeButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        scanCodeButton.backgroundColor = UIColor.scanMeButtonColor
        scanCodeButton.layer.masksToBounds = true
        scanCodeButton.layer.cornerRadius = 8
        scanCodeButton.titleLabel?.text = L10n.QRCode.scanMe
        
        containerView.backgroundColor = .white
    }
    
    private func checkScanPermissions() -> Bool {
      do {
        return try QRCodeReader.supportsMetadataObjectTypes()
      } catch let error as NSError {
        let alert: UIAlertController

        switch error.code {
        case -11852:
          alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
            DispatchQueue.main.async {
              if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(settingsURL)
              }
            }
          }))

          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        default:
          alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }

        present(alert, animated: true, completion: nil)

        return false
      }
    }
}

// MARK: - Actions

extension SubdomainViewController {
    @IBAction func setSubdomain(_ sender: UIButton) {
        PersistanceManager.setLatestViewController(Constant.ControllerName.home)
        LauncherViewController.showLoginView(fromViewController: nil)
//        LauncherViewController.showHomeScreen(fromViewController: nil)
    }
    
    @IBAction func scanAction(_ sender: AnyObject) {
        /*
         #if targetEnvironment(simulator)
           // your simulator code
         #else
           // your real device code
         #endif
         */
        guard checkScanPermissions() else { 
#if targetEnvironment(simulator)
            
            CachingService.setSubdomain(subdomain: "my-app-3")
            
            self.showLoading()
            self.viewModel.getHomeTemplate()
            return
#else
            return
#endif
        }

        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate               = self

        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
          if let result = result {
            print("Completion with result: \(result.value) of type \(result.metadataType)")
          }
        }

        present(readerVC, animated: true, completion: nil)
    }
}

extension SubdomainViewController {
    private func homeResponse() {
        viewModel.onData = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            PersistanceManager.setLatestViewController(Constant.ControllerName.login)
            LauncherViewController.showLoginView(fromViewController: nil)
        }
    }
}

// MARK: - QRCodeReaderViewController Delegate Methods

extension SubdomainViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        CachingService.setSubdomain(subdomain: result.value)
        reader.stopScanning()
        
        self.showLoading()
        self.viewModel.getHomeTemplate()
        
        dismiss(animated: true, completion: nil)
    }

    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        let cameraName = newCaptureDevice.device.localizedName
          print("Switching capture to: \(cameraName)")
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }
    
}
