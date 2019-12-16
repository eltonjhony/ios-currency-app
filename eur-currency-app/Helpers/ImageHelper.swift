//
//  ImageHelper.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import eur_currency_networking

class ImageHelper: NSObject {

    public static func buildCountryFlag(for countryCode: String = "eur") -> String {
        return "https://www.countryflags.io/\(countryCode.dropLast().lowercased())/flat/64.png"
    }

    public static func load(url: String, completion: @escaping NetworkCompletion) {
        _ = HTTPProvider(configurationProtocol: GenericHTTPProviderConfiguration()).simpleRequest(urlString: url, completion: completion)
    }
}
