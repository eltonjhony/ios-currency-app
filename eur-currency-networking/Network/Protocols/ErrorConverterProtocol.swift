//
//  ErrorConverterProtocol.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

// MARK: - Protocols

public protocol ErrorConverterProtocol {
    func convert(error: Swift.Error) -> AppError
}
