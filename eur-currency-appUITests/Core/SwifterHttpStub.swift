//
//  SwifterHttpStub.swift
//  eur-currency-appUITests
//
//  Created by Elton Jhony Romao de Oliveira on 16/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import Swifter

class SwifterHttpStub {

    typealias JsonReplaceHandler = (_ originalJson: [[String: Any]]?) -> [[String: Any]]?

    let server = HttpServer()

    // MARK: - Public Methods

    func stubRequest(to endpoint: String, with payload: String, replaceHandler: JsonReplaceHandler? = nil) {

        guard let jsonData = readJsonFrom(payload) else {
            assertionFailure("Please specify a valid json path")
            return
        }

        guard var json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            assertionFailure("Could not convert data to json")
            return
        }

        if let replacedJson = replaceHandler?(json as? [[String: Any]] ?? []) {
            json = replacedJson
        }

        let response: ((HttpRequest) -> HttpResponse) = { request in
            request.headers = ["Content-Type": "application/json"]
            return HttpResponse.ok(.json(json as AnyObject))
        }

        server[endpoint] = response
    }

    func jsonToModel<T>(_ fileName: String) -> T? where T: Codable {

        guard let jsonData = readJsonFrom(fileName) else {
            assertionFailure("Please specify a valid json path")
            return nil
        }

        do {
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            assertionFailure("Could not convert the json data to specified model: \(error)")
            return nil
        }
    }

    func startWebServer() {
        do {
            try server.start()
        } catch {
            assertionFailure("Could not start the Swifter server")
        }
    }

    func stopWebServer() {
        server.stop()
    }

    // MARK: - Private Methods

    private func readJsonFrom(_ fileName: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        do {
            return try Data(contentsOf: url, options: .mappedIfSafe)
        } catch {
            assertionFailure("Could not read json from path")
            return nil
        }
    }

}

