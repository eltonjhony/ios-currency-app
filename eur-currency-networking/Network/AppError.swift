//
//  AppError.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

// MARK: - Enums

public enum AppError: Swift.Error {
    case http(Int, Data)
    case unexpected(Swift.Error)
    case custom(Swift.Error)
    case ignored(Swift.Error)
    case generic
    case sessionExpired
    case timedOut
    case notConnected
    case business
}

extension AppError: Equatable {
    public static func equals(lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case let (.http(lhsCode, lhsData), .http(rhsCode, rhsData)):
            return lhsCode == rhsCode && lhsData == rhsData

        case (.unexpected, .unexpected):
            return true

        case (.custom, .custom):
            return true

        case (.ignored, .ignored):
            return true

        case (.sessionExpired, .sessionExpired):
            return true

        case (.timedOut, .timedOut):
            return true

        case (.notConnected, .notConnected):
            return true

        case (.business, .business):
            return true

        default:
            return false
        }
    }

    public static func == (lhs: AppError, rhs: AppError) -> Bool {
        return equals(lhs: lhs, rhs: rhs)
    }
}
