//
//  CustomLoadingIndicator.swift
//  flyers
//
//  Created by Eslam Ali on 10/10/2023.
//

import UIKit
import Lottie

enum LoaderType: String {
    case loading
}

protocol CustomLoadingManager {
    func show(withDelay: Bool)
    func dismiss()
}

final class CustomLoadingIndicator: CustomLoadingManager {
    
    // MARK: - Variables
    static let manager: CustomLoadingManager = CustomLoadingIndicator()
    lazy private var overlayView = UIView()
    lazy private var animationView = LottieAnimationView()
    
    // MARK: - Initlizers
    private init() {}
    
    // MARK: - Functions
    internal func dismiss() {
        DispatchQueue.main.async { [ weak self ] in
            guard let strongSelf = self else { return }
            let strongAnimationView = strongSelf.animationView
            if strongAnimationView.isAnimationPlaying {
                strongAnimationView.stop()
            }
            strongAnimationView.removeFromSuperview()
            let strongOverlayView = strongSelf.overlayView
            strongOverlayView.removeFromSuperview()
        }
    }
    
    internal func show(withDelay: Bool) {
        dismiss()
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            guard let window = AppManager.shared.window else { return }
            strongSelf.overlayView = UIView(frame: UIScreen.main.bounds)
            strongSelf.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
            strongSelf.animationView = .init(name: LoaderType.loading.rawValue)
            strongSelf.animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            strongSelf.animationView.center = strongSelf.overlayView.center
            strongSelf.animationView.contentMode = .scaleAspectFit
            strongSelf.animationView.loopMode = .loop
            strongSelf.animationView.animationSpeed = 1
            
            //            let jeremyGif = UIImage.gifImageWithName("loading")
            //            let imageView = UIImageView(image: jeremyGif)
            //            imageView.frame = CGRect(x: -50.0,
            //                                     y: -50.0,
            //                                     width: 150,
            //                                     height: 150)
            //            imageView.center = strongSelf.overlayView.center
            //            strongSelf.overlayView.addSubview(imageView)
            
            if withDelay {
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
                    window.addSubview( strongSelf.overlayView)
                    strongSelf.overlayView.addSubview(strongSelf.animationView)
                    strongSelf.animationView.play()
                    //                    window.bringSubviewToFront(strongSelf.overlayView)
                }
            } else {
                window.addSubview( strongSelf.overlayView)
                strongSelf.overlayView.addSubview(strongSelf.animationView)
                strongSelf.animationView.play()
            }
        }
    }
    
    private func getCurrentViewController() -> UIViewController? {
        let keyWindow = AppManager.shared.window
        guard var topController = keyWindow?.rootViewController else { return nil }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}
