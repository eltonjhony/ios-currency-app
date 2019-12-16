//
//  UILabel.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

extension UILabel {

    func largeBold() {
        bold(with: 18)
    }

    func bold(with size: Float) {
        font = UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
}
