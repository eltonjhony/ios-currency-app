//
//  Dynamic.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias BindType = ((T) -> Void)

    // MARK: - Properties

    private var binds: [BindType] = []

    /// Dynamic raw value
    var value: T {
        didSet {
            execBinds()
        }
    }

    // MARK: - Initialize

    /// Initializer
    ///
    /// - Parameter val: initial dynamic value
    init(_ val: T) {
        value = val
    }

    // MARK: - Public Methods

    /// Bind value for changes
    ///
    /// - Parameters:
    ///   - skip: Should skip initil closure call
    ///   - bind: closure to execute every time value changed
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        if skip {
            return
        }
        bind(value)
    }

    // MARK: - Private Methods

    private func execBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}
