//
//  BusinessError.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

public enum BusinessError: Swift.Error {
    case parse(String)
    case invalidValue(String)
    case invalidResponse
    case offlineMode
    case loggedOut
    case unableToRetrieveData
}

// MARK: - Handle error protocol

extension BusinessError: HandleError {
    public func handle(completion: () -> Void) {
        if self == .offlineMode {
            print("Network not reachable")
        } else {
            print("Handle specific tecnical errors here as it become necessary to keep it uniform through the all app")
        }
        
        completion()
    }
}

extension BusinessError: Equatable {
    public static func equals(lhs: BusinessError, rhs: BusinessError) -> Bool {
        switch (lhs, rhs) {
        case let (.parse(lhsError), .parse(rhsError)):
            return lhsError == rhsError
        case let (.invalidValue(lhsError), .parse(rhsError)):
            return lhsError == rhsError
        case (.unableToRetrieveData, .unableToRetrieveData):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.offlineMode, .offlineMode):
            return true
        case (.loggedOut, .loggedOut):
            return true

        default:
            return false
        }
    }

    public static func == (lhs: BusinessError, rhs: BusinessError) -> Bool {
        return equals(lhs: lhs, rhs: rhs)
    }
}
