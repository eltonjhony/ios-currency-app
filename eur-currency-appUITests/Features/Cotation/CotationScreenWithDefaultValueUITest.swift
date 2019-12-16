//
//  CotationScreenWithDefaultValueUITest.swift
//  eur-currency-appUITests
//
//  Created by Elton Jhony Romao de Oliveira on 16/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

@testable import eur_currency_app
import XCTest

class CotationScreenWithDefaultValueUITest: XCTestCaseBase {

    override func setUp() {
        super.setUp()
    }

    /**
        Make sure to execute this test by using an Iphone 11 Pro Max Simulator
     */
    func testScreen() {
        httpStub.stubRequest(to: EndpointProperties.exchangeRateEurEndpoint.rawValue, with: "mocked-cotation")
        app.launch()
        waitForElementExists(app.textFields[Accessibility.CotationView.baseRateTextFieldIdentifier])
        verifySnapshotView(framesToRemove: getAppBarFrame())
    }

    override func tearDown() {
        super.tearDown()
    }
}
