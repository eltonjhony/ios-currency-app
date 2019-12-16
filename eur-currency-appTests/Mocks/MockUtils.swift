//
//  MockUtils.swift
//  eur-currency-appTests
//
//  Created by Elton Jhony Romao de Oliveira on 15/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import Swinject
import eur_currency_networking
@testable import eur_currency_app

enum ResponseType {
    case success
    case error
}

class MockUtils: NSObject {

    let container: Container = {
        let container = Container()
        return container
    }()

    func mockRepositoryWith(response: Cotation) -> CotationRepositoryProtocol? {
        container.register(CotationRepositoryProtocol.self) { r in
            return CotationRepositoryMock(response: response, error: nil, type: .success)
        }
        
        return container.resolve(CotationRepositoryProtocol.self)
    }
    
}

final class CotationRepositoryMock: CotationRepositoryProtocol {

    private let response: Cotation?
    private let error: AppError?
    private let type: ResponseType

    init(response: Cotation?, error: AppError?, type: ResponseType) {
        self.response = response
        self.error = error
        self.type = type
    }

    func fetch(completion: @escaping ResourceCompletion<Cotation>) {
        switch type {
        case .success:
            Resource<Cotation>(value: response!).execute(completion)
        case .error:
            Resource(error: error!).execute(completion)
        }
    }

}
