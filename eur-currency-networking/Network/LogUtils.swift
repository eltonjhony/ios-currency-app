//
//  LogUtils.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

class LogUtils {
    static func logRequest(_ urlRequest: URLRequest) {
        var log: [String] = []
        log.append("External HTTP request:")
        if let httpMethod = urlRequest.httpMethod {
            log.append(" Method '\(httpMethod)'.")
        }
        if let url = urlRequest.url {
            log.append(" Url '\(url)'.")
        }
        if let headerFields = urlRequest.allHTTPHeaderFields {
            log.append(" Header fields '\(headerFields)'.")
        }
        if let body = urlRequest.httpBody {
            log.append(" Body '\(String(bytes: body, encoding: .utf8) ?? "")'")
        }
        print(log.joined())
    }

    static func logResponse(_ bodyResponse: Data?, _ response: URLResponse?, _ error: Error?) {
        var log: [String] = []
        if let response = response {
            if let httpUrlResponse = response as? HTTPURLResponse {
                log.append("External HTTP response: Response '\(httpUrlResponse.statusCode)'. Content Type '\(httpUrlResponse.allHeaderFields)'\n")
            } else {
                log.append("External HTTP response: Response '\(response)'\n")
            }
        }
        if let bodyResponse = bodyResponse {
            log.append("External HTTP response body:")
            log.append(" Data '\(String(bytes: bodyResponse, encoding: .utf8) ?? "")'\n")
        }
        if let error = error {
            log.append("External HTTP response error \(error)")
        }
        print(log.joined())
    }
}
