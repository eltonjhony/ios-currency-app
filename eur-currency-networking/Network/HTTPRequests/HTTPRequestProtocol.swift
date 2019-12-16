//
//  HTTPRequestProtocol.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

// MARK: - Typealias

public typealias FetchCompletion<T, R> = (HTTPURLResponse, T) throws -> R
public typealias DataCallBack = (@escaping () throws -> (Int, Data?)) -> Void
public typealias NetworkHeader = [String: String]

// MARK: - Enums

public enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - Protocols

public protocol HTTPRequestProtocol {
    var httpMethod: HTTPRequestMethod { get }
    var urlPath: String { get }
    var headerFields: NetworkHeader? { get set }
    var errorConveter: ErrorConverterProtocol? { get set }
    var httpBody: Encodable? { get set }
    var queryParameters: [String]? { get set }

    func fetch<T: Decodable, R>(provider: HTTPProviderProtocol,
                                resourceCompletion: @escaping ResourceCompletion<R>,
                                resourceTransformer: @escaping (FetchCompletion<T, R>)) -> RequestProtocol
    func fetch<T: Decodable>(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<T>) -> RequestProtocol
    func fetch(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<Void>) -> RequestProtocol
    func fetch<T>(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<T>, resourceTransformer: @escaping FetchCompletion<Data, T>) -> RequestProtocol
}

// MARK: - Extensions

extension HTTPRequestProtocol {
    // MARK: - Public Methods

    public func fetch<T: Decodable, R>(provider: HTTPProviderProtocol,
                                       resourceCompletion: @escaping ResourceCompletion<R>,
                                       resourceTransformer: @escaping (FetchCompletion<T, R>)) -> RequestProtocol {
        func networkCompletion(_ response: () throws -> (HTTPURLResponse, Data)) {
            var resource: Resource<R>?
            do {
                let (httpResponse, data) = try response()

                let result: T = try JSONDecoder().decode(T.self, from: data)
                resource = Resource(value: try resourceTransformer(httpResponse, result))
            } catch {
                resource = handleError(error: error)
            }
            resource?.execute(resourceCompletion)
        }
        return provider.request(self, completion: networkCompletion)
    }

    public func fetch<T: Decodable>(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<T>) -> RequestProtocol {
        return fetch(provider: provider, resourceCompletion: resourceCompletion) { (_, result: T) in
            result
        }
    }

    public func fetch(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<Void>) -> RequestProtocol {
        return fetch(provider: provider) { (resource: Resource<EmptyResult>) in
            resource.success { _ in
                let resource = Resource(value: ())
                resource.execute(resourceCompletion)
            }
            resource.failure { error, _ in
                let resource = Resource<Void>(error: error)
                resource.execute(resourceCompletion)
            }
        }
    }

    /// Make a fetch call
    ///
    /// - Parameter provider: Provider that will be used to the call
    /// - Parameter resourceCompletion: Final callback to be executed
    /// - Parameter resourceTransformer: Callback for parsing the data
    /// - Returns: The reference to the request
    public func fetch<T>(provider: HTTPProviderProtocol,
                         resourceCompletion: @escaping ResourceCompletion<T>,
                         resourceTransformer: @escaping FetchCompletion<Data, T>) -> RequestProtocol {
        func networkCompletion(_ response: () throws -> (HTTPURLResponse, Data)) {
            var resource: Resource<T>?
            do {
                let (httpResponse, data) = try response()

                resource = Resource(value: try resourceTransformer(httpResponse, data))
            } catch {
                resource = handleError(error: error)
            }
            resource?.execute(resourceCompletion)
        }
        return provider.request(self, completion: networkCompletion)
    }

    // MARK: - Private methods

    private func handleError<T>(error: Swift.Error) -> Resource<T>? {
        switch error {
        case AppError.ignored:
            return nil
        case let appError as AppError:
            return Resource(error: appError)
        default:
            return Resource(error: AppError.unexpected(error))
        }
    }
}

public struct EmptyResult: Codable {
    public init() {
        // Intentionally unimplemented...
    }
}
