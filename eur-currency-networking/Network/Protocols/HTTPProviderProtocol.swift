//
//  HTTPProviderProtocol.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

// MARK: - Typealias

public typealias NetworkCompletion = (() throws -> (HTTPURLResponse, Data)) -> Void

// MARK: - Protocols

public protocol HTTPProviderProtocol {
    // MARK: - Properties

    var configurationProtocol: HTTPProviderConfigurationProtocol { get }

    // MARK: - Public Methods

    func request(_ request: HTTPRequestProtocol, completion: @escaping NetworkCompletion) -> RequestProtocol
    func simpleRequest(urlString: String, completion: @escaping NetworkCompletion)
}
