//
//  BaseHTTPProviderConfiguration.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

open class BaseHTTPProviderConfiguration {

    public init() {
        // Intentionally unimplemented...
    }

    
    // MARK: - Public Methods

    public func willLoadRequest(_ request: NSMutableURLRequest) {
        var defaultHeaders = headerFields()
        if let customHeader = request.allHTTPHeaderFields {
            defaultHeaders.merge(customHeader) { current, _ in current }
        }
        request.allHTTPHeaderFields = defaultHeaders
    }

    open func headerFields() -> [String: String] {
        preconditionFailure("This method must be overridden")
    }
}
