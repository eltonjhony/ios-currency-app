//
//  NetworkingProtocol.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

// MARK: - Protocols

@objc public protocol NetworkingProtocol {

    func networkRequest(_ request: URLRequest, response: URLResponse?, requestDuration: TimeInterval, andData data: Data?)
}

public protocol HTTPProviderConfigurationProtocol {
    // MARK: - Properties

    var baseURL: String { get }
    var urlSession: URLSessionProtocol { get }
    var networkingProtocol: NetworkingProtocol? { get set }

    // MARK: - Public Methods

    func willLoadRequest(_ request: NSMutableURLRequest)
}

public final class DefaultSessionDelegate: NSObject, URLSessionDelegate {

    // MARK: - Public Methods

    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
}
