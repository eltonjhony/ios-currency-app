//
//  UIView.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 15/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

extension UIView {

    func arrange(target: UIActivityIndicatorView) {
        addSubview(target)
        center(element: target)
    }
    
    func center(element: UIView) {
        element.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        element.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
