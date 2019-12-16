//
//  CotationInteractorTest.swift
//  eur-currency-appTests
//
//  Created by Elton Jhony Romao de Oliveira on 15/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import XCTest
@testable import eur_currency_app

class CotationInteractorTest: XCTestCase {

    func testFetchEurCotationWithSuccess() {
        let repository = MockUtils().mockRepositoryWith(response: getSuccessResponse())
        let interactor: CotationInteractorProtocol = CotationInteractor(repository: repository)
        
        interactor.fetchEurCotation(1.0) { (cotations, error) in
            guard let cotations = cotations else {
                XCTFail()
                return
            }

            XCTAssertFalse(cotations.isEmpty)
            XCTAssertTrue(cotations.count == 3)
            XCTAssertTrue(cotations[0].countryCode == "HKD")
            XCTAssertTrue(cotations[1].countryCode == "ISK")
            XCTAssertTrue(cotations[2].countryCode == "CAD")

            XCTAssertTrue(cotations[0].rate == 1.0)
            XCTAssertTrue(cotations[1].rate == 4.0)
            XCTAssertTrue(cotations[2].rate == 6.0)
        }
    }

    func testFetchEurCotationWithCalculationSuccess() {

        let referenceValue: Float = 5.0

        let repository = MockUtils().mockRepositoryWith(response: getSuccessResponse())
        let interactor: CotationInteractorProtocol = CotationInteractor(repository: repository)

        interactor.fetchEurCotation(referenceValue) { (cotations, error) in
            guard let cotations = cotations else {
                XCTFail()
                return
            }

            XCTAssertFalse(cotations.isEmpty)
            XCTAssertTrue(cotations.count == 3)
            XCTAssertTrue(cotations[0].countryCode == "HKD")
            XCTAssertTrue(cotations[1].countryCode == "ISK")
            XCTAssertTrue(cotations[2].countryCode == "CAD")

            XCTAssertTrue(cotations[0].rate == (1.0 * referenceValue))
            XCTAssertTrue(cotations[1].rate == (4.0 * referenceValue))
            XCTAssertTrue(cotations[2].rate == (6.0 * referenceValue))
        }
    }

}

extension CotationInteractorTest {

    func getSuccessResponse() -> Cotation {
        return Cotation(base: "EUR", date: "2019-12-13", rates: ["CAD": 6.0, "HKD": 1.0, "ISK": 4.0])
    }
}
