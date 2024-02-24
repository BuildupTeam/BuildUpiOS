//
//  LanguageBottomSheetViewController.swift
//  flyers
//
//  Created by Mohammed Khaled on 19/02/2023.
//

import UIKit
import PanModal

protocol LanguageBottomSheetDelegate: AnyObject {
    func languageSelected(languageModel: LanguageModel, languages: [LanguageModel])
}

class LanguageBottomSheetViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    
    weak var delegate: LanguageBottomSheetDelegate?
    var languages = (DeepCopyService.getSuportedLanguagesCopy(languages: LocalizationManager.supportedLanguages)) ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerTableViewCells()
    }
    
    private func setupView() {
        self.view.backgroundColor = .clear
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 30
        
        lineView.backgroundColor = .separator
        
        tableView.backgroundColor = .white
        
        let footerView = UIView()
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
        
        tableView.separatorColor = .white
        
        titleLabel.text = L10n.Profile.changeLanguage
        titleLabel.font = .appFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: LanguageElementTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: LanguageElementTableViewCell.identifier)
    }
    
    private func updateSelection(index: Int) {
        for languageModel in languages {
            languageModel.isSelected = false
        }
        
        languages[index].isSelected = true
    }
}

// MARK: - Actions
extension LanguageBottomSheetViewController {

    @IBAction func closeAction(sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - TableView Delegate
extension LanguageBottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LanguageElementTableViewCell.identifier,
            for: indexPath) as? LanguageElementTableViewCell
        else { return UITableViewCell() }
        
        cell.languageModel = languages[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addFeedbackGenerator()
        updateSelection(index: indexPath.row)
        self.tableView.reloadData()
        
        self.dismiss(animated: false) {
            self.delegate?.languageSelected(languageModel: self.languages[indexPath.row], languages: self.languages)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:
            "FRESHCHAT_USER_LOCALE_CHANGED"),
            object: self, userInfo: nil)
        }
    }
}

// MARK: - PanModal
extension LanguageBottomSheetViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }
    
    var showDragIndicator: Bool {
        return false
    }
}
