//
//  LocalizationKeys.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 15/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import UIKit

enum LocalizationKeys: String {
    case appTitle, euroSymbol, currencySymbol, calculateLabel, closeLabel
}

extension LocalizationKeys {
    var value: String {
        return String.localized(key: self)
    }

    func value(withFont font: UIFont, andColor color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: value,
                                         attributes: [NSAttributedString.Key.font: font,
                                                      NSAttributedString.Key.foregroundColor: color])
    }
}
