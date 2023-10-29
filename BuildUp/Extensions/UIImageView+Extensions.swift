//
//  UIImageView+Extensions.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import UIKit
import SDWebImage
import SDWebImageSVGCoder

enum FilterType: String {
    case chrome = "CIPhotoEffectChrome"
    case fade = "CIPhotoEffectFade"
    case instant = "CIPhotoEffectInstant"
    case mono = "CIPhotoEffectMono"
    case noir = "CIPhotoEffectNoir"
    case process = "CIPhotoEffectProcess"
    case tonal = "CIPhotoEffectTonal"
    case transfer = "CIPhotoEffectTransfer"
}

// swiftlint:disable force_unwrapping
extension UIImageView {
    
    func setImage(with imageModel: String, placeholderImage: UIImage? = nil ) {
        if let imageUrl = URL(string: imageModel) {
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            self.backgroundColor = UIColor.systemGray4
            self.sd_setImage(
                with: imageUrl,
                placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0)) { (image, error, test, test2) in
                    print(image)
                    print(error.debugDescription)
                    print(test)
                    self.image = image
                    print(test2)
            }
        } else {
            self.image = placeholderImage
        }
    }
    
    func setImageWithCallBack(with imageModel: String, placeholderImage: UIImage? = nil, compeltion: @escaping ((UIImage?) -> Void)) {
        if let imageUrl = URL(string: imageModel) {
            
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            
            self.sd_setImage(
                with: imageUrl,
                placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0)) { (image, _, _, _) in
                   
                    compeltion(image)
                    
            }
        } else {
            self.image = placeholderImage
        }
    }
    
    func setImage(image: UIImage?) {
        
        self.sd_setImage(
            with: nil,
            placeholderImage: image)
    }
    
    func tentImageColor(color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}

extension UIImage {
    
    func addFilter(filter: FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        return UIImage(cgImage: cgImage!)
    }
}

extension UIImageView {
    func generateQRCode(from string: String) {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                let qrCodeImage = UIImage(ciImage: output)
                self.image = qrCodeImage
            }
        }
    }
}
