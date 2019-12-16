//
//  String.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

extension String {

    var floatValue: Float? {
        return (self as NSString).floatValue
    }
    
    static func localized(key: LocalizationKeys) -> String {
        return NSLocalizedString(key.rawValue,
                                 tableName: "Localizable_en_US",
                                 bundle: Bundle.local,
                                 value: "MISSING - NOT REQUIRED",
                                 comment: "")
    }
    
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
