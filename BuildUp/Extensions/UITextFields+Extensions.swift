//
//  UITextFields+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import UIKit

extension UITextField {
    
    func setPlaceholder(placeholder: String, font: UIFont) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightSlateGray,
            NSAttributedString.Key.font: font
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    func setPlaceholder(placeholder: String, font: UIFont, color: UIColor) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
}

extension UITextField {
    func showDoneButtonOnKeyboard() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
//            barButtonSystemItem: .done,
            target: self,
            action: #selector(resignFirstResponder))
        
        var toolBarItems = [UIBarButtonItem]()
        toolBarItems.append(flexSpace)
        toolBarItems.append(doneButton)
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = toolBarItems
        doneToolbar.sizeToFit()
        inputAccessoryView = doneToolbar
    }
}
