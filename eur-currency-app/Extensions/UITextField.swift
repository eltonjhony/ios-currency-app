//
//  UITextField.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

extension UITextField {

    func addActionButton(target: UIViewController, text: String, style: UIBarButtonItem.Style, action: Selector?) {
        addActionItem(target: target, item: UIBarButtonItem(title: text, style: style, target: target, action: action))
    }
    
    func addSpaceItem(target: UIViewController) {
        addActionItem(target: target, item: UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
    }

    private func addActionItem(target: UIViewController, item: UIBarButtonItem) {
        var uiToolbar: UIToolbar? = nil

        if let toolbar = inputAccessoryView as? UIToolbar {
            uiToolbar = toolbar
        } else {
            uiToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        }

        if let toolbarItem = uiToolbar {

            toolbarItem.barStyle = .default

            if let addedItems = toolbarItem.items {
                toolbarItem.items = addedItems + [item]
            } else {
                toolbarItem.items = [item]
            }

            toolbarItem.sizeToFit()
            inputAccessoryView = toolbarItem
        }
    }
    
}
