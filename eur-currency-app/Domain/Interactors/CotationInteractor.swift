//
//  CotationInteractor.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import eur_currency_networking

typealias EurCotationCompletion = (_ data: [CotationView]?, _ error: String?) -> Void

protocol CotationInteractorProtocol {
    func fetchEurCotation(_ referenceValue: Float, _ completion: @escaping EurCotationCompletion)
}

class CotationInteractor: CotationInteractorProtocol {
    
    private let repository: CotationRepositoryProtocol?

    init(repository: CotationRepositoryProtocol?) {
        self.repository = repository
    }

    func fetchEurCotation(_ referenceValue: Float, _ completion: @escaping EurCotationCompletion) {
        repository?.fetch { (resource: Resource<Cotation>) in
            resource.success { cotation in
                CotationCaching.shared.cache(cotation)
                completion(self.calculateRates(referenceValue, cotation.rates), nil)
            }
            resource.failure { error, _ in
                print("Failure Fetch Cotation - \(error)")
                completion(nil, error.localizedDescription)
            }
            resource.finally {
                print("Finally Fetch Cotation")
            }
        }
    }

    private func calculateRates(_ referenceValue: Float, _ rates: [String: Float]) -> [CotationView] {
        return rates.keys.compactMap {
            CotationView(countryCode: $0, rate: referenceValue * (rates[$0] ?? 0))
        }.sorted(by: { $0.rate < $1.rate })
    }
}
