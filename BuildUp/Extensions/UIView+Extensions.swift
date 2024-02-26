//
//  UIView+Extensions.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import  UIKit

extension UIView {
    func showView() {
        self.isHidden = false
        if self.isHidden == true {
            self.showView()
        }
    }
    
    func hideView() {
        self.isHidden = true
        if self.isHidden == false {
            self.hideView()
        }
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}

extension UICollectionReusableView {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [
            UIColor.primaryColor.cgColor,
            UIColor.orange.cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    func setGradientBackground(
        colorTop: UIColor,
        colorBottom: UIColor,
        viewWidth: CGFloat,
        viewHeight: CGFloat,
        cornerRadius: CGFloat) {
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [0, 0.7]
            gradientLayer.cornerRadius = cornerRadius
            gradientLayer.frame = CGRect(x: bounds.minX, y: bounds.minY, width: viewWidth, height: viewHeight)
            
            layer.insertSublayer(gradientLayer, at: 0)
        }
    
    func setViewCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryColor.cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.2
    }
    
    func setShadow(
        shadowRadius: CGFloat,
        xOffset: Int,
        yOffset: Int,
        color: UIColor,
        opacity: Float,
        cornerRadius: CGFloat = CGFloat(0),
        masksToBounds: Bool) {
            
            let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0)
            self.layer.shadowPath = shadowPath0.cgPath
            
            self.layer.cornerRadius = cornerRadius
            self.layer.shadowColor = UIColor(red: 0.655, green: 0.655, blue: 0.655, alpha: 0.23).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = shadowRadius
            self.layer.shadowOpacity = opacity
            self.layer.masksToBounds = masksToBounds
        }
    
    func setShadowBorder(
        shadowRadius: CGFloat,
        xOffset: Int,
        yOffset: Int,
        color: UIColor,
        opacity: Float,
        cornerRadius: CGFloat = CGFloat(0),
        masksToBounds: Bool,
        borderColor: UIColor) {
            
            let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0)
            self.layer.shadowPath = shadowPath0.cgPath
            
            self.layer.cornerRadius = cornerRadius
            self.layer.shadowColor = UIColor(red: 0.655, green: 0.655, blue: 0.655, alpha: 0.23).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = shadowRadius
            self.layer.shadowOpacity = opacity
            self.layer.masksToBounds = masksToBounds
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
        }
}

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func openActivityViewController(title: String? = nil,
                                    urlString: String? = nil,
                                    image: UIImage? = nil) {
        var activityItems = [Any]()
        if let title = title {
            activityItems.append(title)
        }
  
        if let url = urlString?.url {
            activityItems.append(url)
        }
        if let image = image {
            activityItems.append(image)
        }
        
        self.openActivityViewController(activityItems: activityItems)
    }
    
    func openActivityViewController(activityItems: [Any]) {
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let popoverPresentationController = activityViewController.popoverPresentationController
            
            popoverPresentationController?.permittedArrowDirections = .any
            popoverPresentationController?.sourceView = UIButton(frame: CGRect(x: 500, y: 500, width: 30, height: 30))
            
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIButton {
    func setCornerRadius(_ radious: CGFloat ) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radious
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: - Intiating Nib View
extension Bundle {

    static func loadView<T: UIView>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}

protocol NibInstantiatable {
    static var nibName: String { get }
}

extension NibInstantiatable {

    static var nibName: String { return String(describing: self) }

    static func instantiateFromNib() -> Self {
        return instantiateWithName(name: nibName)
    }

    static func instantiateWithOwner(owner: AnyObject?) -> Self {
        return instantiateWithName(name: nibName, owner: owner)
    }

    static func instantiateWithName(name: String, owner: AnyObject? = nil) -> Self {
        let nib = UINib(nibName: name, bundle: nil)
        guard let view = nib.instantiate(withOwner: owner, options: nil).first as? Self else {
            fatalError("failed to load \(name) nib file")
        }
        return view
    }
}

extension UIView: NibInstantiatable {}

extension UIView {
    func createDottedLine(width: CGFloat, thickness: CGFloat, color: UIColor) {
      let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color.cgColor
      caShapeLayer.lineWidth = thickness
      caShapeLayer.lineDashPattern = [3, 2]
      let cgPath = CGMutablePath()
    let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: width, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
    self.layer.addSublayer(caShapeLayer)
   }
}
