//
//  HTTPProvider.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

public class HTTPProvider: HTTPProviderProtocol {

    // MARK: - Properties

    public let configurationProtocol: HTTPProviderConfigurationProtocol

    // MARK: - Initializers

    public init(configurationProtocol: HTTPProviderConfigurationProtocol) {
        self.configurationProtocol = configurationProtocol
    }

    // MARK: - Public Methods

    public func request(_ request: HTTPRequestProtocol, completion: @escaping NetworkCompletion) -> RequestProtocol {
        let urlRequest = createURLRequest(request)
        LogUtils.logRequest(urlRequest)
        let requestDate = Date()

        let sessionTask: URLSessionTask = configurationProtocol.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            let requestDuration = Date().timeIntervalSince(requestDate)
            self?.handleRequest(data: data, response: response, error: error, request: request, requestDuration: requestDuration, completion: completion)
        }
        sessionTask.resume()
        return ApiRequest(sessionTask: sessionTask)
    }

    public func simpleRequest(urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion { throw AppError.generic }
            }
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                completion { throw AppError.unexpected(URLError(URLError.cannotParseResponse)) }
                return
            }

            // check if there is an httpStatus code ~= 200...299 (Success)
            if 200 ... 299 ~= httpResponse.statusCode {
                DispatchQueue.main.async {
                    completion { (httpResponse, responseData as Data) }
                }
            } else {
                DispatchQueue.main.async {
                    completion { throw AppError.http(httpResponse.statusCode, responseData) }
                }
            }
        }).resume()

    }

    // MARK: - Private Methods

    private func handleRequest(data: Data?, response: URLResponse?, error: Error?, request: HTTPRequestProtocol, requestDuration: TimeInterval, completion: @escaping NetworkCompletion) {
        do {

            LogUtils.logResponse(data, response, error)
            if let networkingDelegate = configurationProtocol.networkingProtocol {
                networkingDelegate.networkRequest(createURLRequest(request), response: response, requestDuration: requestDuration, andData: data)
            }

            if let error = error {
                throw error
            }

            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                throw AppError.unexpected(URLError(URLError.cannotParseResponse))
            }

            // check if there is an httpStatus code ~= 200...299 (Success)
            if 200 ... 299 ~= httpResponse.statusCode {
                DispatchQueue.main.async {
                    completion { (httpResponse, responseData as Data) }
                }
            } else {
                throw AppError.http(httpResponse.statusCode, responseData)
            }
        } catch {
            DispatchQueue.main.async {
                completion {
                    if let appError = request.errorConveter?.convert(error: error) {
                        throw appError
                    }
                    throw DefaultErrorConverter().convert(error: error)
                }
            }
        }
    }

    private func createURLRequest(_ request: HTTPRequestProtocol) -> URLRequest {
        let urlRequest = NSMutableURLRequest()
        urlRequest.httpMethod = request.httpMethod.rawValue

        guard let completeURL = self.completeURL(request.urlPath) else {
            assertionFailure("Invalid URL")
            return urlRequest as URLRequest
        }
        guard var urlComponents = URLComponents(url: completeURL, resolvingAgainstBaseURL: false) else {
            assertionFailure("Invalid URL")
            return urlRequest as URLRequest
        }

        // adding parameters to body
        if let httpBody = request.httpBody, let data = httpBody.encodedData {
            urlRequest.httpBody = data
        }

        // adding parameters to query string
        if let parametersItems = request.queryParameters {
            urlComponents.query = parametersItems.joined(separator: "&")
        }

        urlRequest.url = urlComponents.url
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        urlRequest.allHTTPHeaderFields = request.headerFields

        // configuring Custom URLRequest
        configurationProtocol.willLoadRequest(urlRequest)

        return urlRequest as URLRequest
    }

    private func completeURL(_ componentOrUrl: String) -> URL? {
        if componentOrUrl.contains("http://") || componentOrUrl.contains("https://") {
            return URL(string: componentOrUrl)
        } else {
            return URL(string: "\(configurationProtocol.baseURL)\(componentOrUrl)")
        }
    }
}
