//
//  Encodable.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

extension Encodable {

    public subscript(key: String) -> Any? {
        return dictionary[key]
    }

    public var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }

    public var encodedDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    public var encodedData: Data? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return data
    }

    public func urlQuery() -> [String]? {
        if let json = encodedDictionary {
            return json.map { par -> String in
                let value = String(describing: par.1) != "" ? String(describing: par.1) : "null"
                if value == "null" {
                    return ""
                }
                return "\(par.0)=\(value)"
            }
        }
        return nil
    }
}
