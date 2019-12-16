//
//  Cotation.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

struct Cotation: Codable {
    let base: String
    let date: String
    let rates: [String: Float]
}

struct CotationView {
    let countryImageUrl: String
    let countryCode: String
    let rate: Float

    init(countryCode: String, rate: Float) {
        self.countryImageUrl = ImageHelper.buildCountryFlag(for: countryCode)
        self.countryCode = countryCode
        self.rate = rate
    }
}
