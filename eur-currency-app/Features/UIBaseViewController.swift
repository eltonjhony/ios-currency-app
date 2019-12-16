//
//  UIBaseViewController.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 12/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

class UIBaseViewController: UIViewController, ViewFromNib {

    let uiActivityIndicator: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.color = UIColor.white
        element.backgroundColor = UIColor.systemGreen
        element.hidesWhenStopped = true
        element.stopAnimating()
        return element
    }()

}
