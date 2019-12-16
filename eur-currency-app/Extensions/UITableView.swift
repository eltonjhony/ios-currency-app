//
//  UITableView.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {

    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.className) as? T
    }
}
