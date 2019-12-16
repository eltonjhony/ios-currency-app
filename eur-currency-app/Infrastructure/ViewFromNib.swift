//
//  ViewFromNib.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 12/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

protocol ViewFromNib {
    static func instantiate() -> Self
}

extension ViewFromNib where Self: UIViewController {

    static func instantiate() -> Self {
        return Self(nibName: String(describing: self), bundle: Bundle.local)
    }
}
