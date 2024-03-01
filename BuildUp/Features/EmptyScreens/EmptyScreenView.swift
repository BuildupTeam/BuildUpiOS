//
//  EmptyScreenView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import UIKit

enum EmptyScreenType {
    case emptyScreen
    case loginFirst
}

// swiftlint:disable all
class EmptyScreenView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var backToHomeButton: UIButton!

    var screenType: EmptyScreenType? {
        didSet {
            if screenType == .emptyScreen {
                backToHomeButton.setTitle(L10n.EmptyScreen.noData, for: .normal)
            } else if screenType == .loginFirst {
                backToHomeButton.setTitle(L10n.EmptyScreen.Button.login, for: .normal)
            }
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var emptyImage: UIImage? {
        didSet {
            emptyImageView.image = emptyImage?.withRenderingMode(.alwaysTemplate)
            emptyImageView.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        }
    }
    
    var showButton: Bool? = false {
        didSet {
            if showButton ?? false {
                backToHomeButton.hideView()
            } else {
                backToHomeButton.hideView()
            }
        }
    }
    
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
    
    private func commomInit() {
        
    }
}

// MARK: - private functions
extension EmptyScreenView {
    private func setupView() {
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        titleLabel.font = .appFont(ofSize: CGFloat(16), weight: .medium)
        titleLabel.textColor = .titlesBlack
        titleLabel.textAlignment = .center
        
        backToHomeButton.layer.cornerRadius = 6
        backToHomeButton.backgroundColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        backToHomeButton.titleLabel?.font = .appFont(ofSize: 17, weight: .medium)
        backToHomeButton.setTitleColor(.white, for: .normal)
        
        if screenType == .emptyScreen {
            backToHomeButton.setTitle(L10n.EmptyScreen.noData, for: .normal)
        } else if screenType == .loginFirst {
            backToHomeButton.setTitle(L10n.EmptyScreen.Button.login, for: .normal)
        }
    }
}

// MARK: - Actions
extension EmptyScreenView {
    @IBAction func backToHomeAction(_ sender: Any) {
        if screenType == .emptyScreen {
            LauncherViewController.showTabBar(fromViewController: nil)
        } else if screenType == .loginFirst {
            LauncherViewController.showLoginView(fromViewController: nil)
        }
    }
}
