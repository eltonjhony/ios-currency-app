//
//  DefaultErrorConverter.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

public class DefaultErrorConverter: ErrorConverterProtocol {

    public init() {
        // Intentionally unimplemented...
    }

    // MARK: - Public Methods

    public func convert(error: Error) -> AppError {
        if let appError = error as? AppError {
            if case let AppError.http(code, _) = appError, [401, 403].contains(code) {
                return AppError.sessionExpired
            }
            return appError
        }

        switch URLError.Code(rawValue: error._code) {
        case .timedOut:
            return AppError.timedOut
        case .notConnectedToInternet:
            return AppError.notConnected
        case .cancelled:
            return AppError.ignored(error)
        default:
            return AppError.unexpected(error)
        }
    }
}
