//
//  Bundle.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 12/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

extension Bundle {

    static var local: Bundle {
        return Bundle(for: AppCoordinator.self)
    }
    
}
