//
//  CurrencyRepository.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import eur_currency_networking

protocol CotationRepositoryProtocol {
    func fetch(completion: @escaping ResourceCompletion<Cotation>)
}

class CotationRepository: CotationRepositoryProtocol {

    private let provider: HTTPProviderProtocol
    private var fetchRequest: HTTPRequestProtocol

    // MARK: - Initialize

    init(provider: HTTPProviderProtocol, fetchRequest: HTTPRequestProtocol) {
        self.provider = provider
        self.fetchRequest = fetchRequest
    }

    // MARK: - Public Methods

    func fetch(completion: @escaping ResourceCompletion<Cotation>) {
        if CotationCaching.shared.isCacheExpired() {
            _ = fetchRequest.fetch(provider: provider, resourceCompletion: completion)
        } else if let cached = CotationCaching.shared.get() {
            Resource<Cotation>(value: cached).execute(completion)
        } else {
            Resource(error: AppError.generic).execute(completion)
        }
    }
}

final class FetchEurCotationHTTPRequest: BaseHTTPRequest {
    override var httpMethod: HTTPRequestMethod { return .get }
    override var urlPath: String { return EndpointProperties.exchangeRateEurEndpoint.rawValue }
}

final class CotationCaching: Caching<Cotation> {

    private override init() {
        super.init()
    }
    
    static var shared: Caching<Cotation> = CotationCaching()

    override func isCacheExpired() -> Bool {
        guard let referenceDate = get()?.date.toDate() else {
            return true
        }

        return NSCalendar.current.isDateInYesterday(referenceDate) && get() != nil
    }
}
