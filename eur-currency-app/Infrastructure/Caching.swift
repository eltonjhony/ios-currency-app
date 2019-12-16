//
//  Caching.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 15/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

open class Caching<T> {

    private var value: T?

    func get() -> T? {
        return self.value
    }

    func cache(_ value: T) {
        self.value = value
    }

    func isCacheExpired() -> Bool {
        return true
    }
}
