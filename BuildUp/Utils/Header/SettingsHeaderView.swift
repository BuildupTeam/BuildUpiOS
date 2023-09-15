//
//  SettingsHeaderView.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import UIKit

protocol SettingsHeaderViewDelegate: AnyObject {
    func backButtonTapped()
}

class SettingsHeaderView: UIView {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var closeImageView: UIImageView!

    weak var delegate: SettingsHeaderViewDelegate?
    var title: String? {
        didSet {
            setPageTitle()
        }
    }
    
    func initialize() {
        backgroundColor = .primaryColor
        progressView.progressTintColor = .primaryColor
        progressView.trackTintColor = .taupe
        progressView.tintColor = .primaryColor
        
        titleLabel.textColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        titleLabel.font = .appFont(ofSize: CGFloat(18.5), weight: .bold)
        
//        closeImageView.image = Asset.icCloseWhite.image
//        closeImageView.tintColor = .white
    }
    
    func setPageTitle() {
        self.titleLabel.text = self.title ?? ""
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        delegate?.backButtonTapped()
    }
    
    func setProgressValue(progress: Float, animated: Bool = true) {
        progressView.setProgress(progress, animated: animated)
        if (progress == 0 || progress == 1) {
            if animated {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    self.progressView.isHidden = true
                }
            } else {
                self.progressView.isHidden = true
            }
        } else {
            self.progressView.isHidden = false
        }
    }
}
