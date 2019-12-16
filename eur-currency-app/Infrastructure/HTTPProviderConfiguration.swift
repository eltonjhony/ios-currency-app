//
//  HTTPProviderConfiguration.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import eur_currency_networking

public class HTTPProviderConfiguration: GenericHTTPProviderConfiguration {

    // MARK: - Properties

    public override init() {
        super.init()
        self.baseURL = self.exchangeUrl()
    }

    private func exchangeUrl() -> String {
        if ProcessInfo.processInfo.arguments.contains("system-under-test") {
            return "http://localhost:8080/"
        }

        return "https://api.exchangeratesapi.io/"
    }
}

public class GenericHTTPProviderConfiguration: BaseHTTPProviderConfiguration, HTTPProviderConfigurationProtocol {
    
    public override init() {
        self.baseURL = ""
        self.urlSession = URLSession(configuration: .ephemeral, delegate: DefaultSessionDelegate(), delegateQueue: nil)
    }

    // MARK: - Properties

    public var baseURL: String
    public let urlSession: URLSessionProtocol
    public var networkingProtocol: NetworkingProtocol?

    // MARK: - public Methods
    override public func headerFields() -> [String: String] {
        let headers = ["Content-Type": "application/json"]
        return headers
    }
}
