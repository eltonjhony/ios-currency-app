//
//  BaseHTTPRequest.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

open class BaseHTTPRequest: HTTPRequestProtocol {
    public init() {
        // Intentionally unimplemented...
    }
    
    open var httpMethod: HTTPRequestMethod {
        assertionFailure("httpMethod must be overridden")
        return .get
    }

    open var urlPath: String {
        assertionFailure("urlPath must be overridden")
        return ""
    }

    open var headerFields: NetworkHeader?
    open var errorConveter: ErrorConverterProtocol?
    open var httpBody: Encodable?
    open var queryParameters: [String]?
    
}
