//
//  HandleError.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

public typealias Error = Swift.Error

public protocol HandleError {
    func handle(completion: () -> Void)
}
