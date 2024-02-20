//
//  HomeLogoView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/02/2024.
//

import UIKit

class HomeLogoView: UIView {

    @IBOutlet private weak var logoImageView: UIImageView!

    override func awakeFromNib() {
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
//    override var intrinsicContentSize: CGSize {
//        return UIView.layoutFittingExpandedSize
//    }
    
    private func commomInit() {
        
    }
    
    func setupView() {
        if let imagePath = CachingService.getThemeData()?.iOSAppIcon?.path {
            logoImageView.setImage(with: imagePath)
            logoImageView.backgroundColor = .clear
//            logoImageView.setImage(image: Asset.icSquadio.image)
        }
    }

}
