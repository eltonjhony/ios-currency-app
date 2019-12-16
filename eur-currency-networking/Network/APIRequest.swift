//
//  ApiRequest.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

public struct ApiRequest: RequestProtocol {
    // MARK: - Properties

    public var sessionTask: URLSessionTask?

    public init(sessionTask: URLSessionTask?) {
        self.sessionTask = sessionTask
    }

    // MARK: - Public Methods

    public func cancel() {
        guard let session = sessionTask  else {
            return
        }

        if session.state == .running || session.state == .suspended {
            session.cancel()
        }
    }
}
