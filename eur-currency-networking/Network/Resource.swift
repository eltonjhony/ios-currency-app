//
//  Resource.swift
//  eur-currency-networking
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

// MARK: - Typealias

public typealias AbortErrorHandling = () -> Void
public typealias SuccessHandle<V> = (V) -> Void
public typealias FailureHandle = (AppError, AbortErrorHandling) -> Void
public typealias FinallyHandle = () -> Void
public typealias ResourceCompletion<T> = (Resource<T>) -> Void
public typealias VoidResourceCompletion = (Resource<Void>) -> Void

public class Resource<V> {
    // MARK: - Properties

    private let value: V?
    private let error: AppError?
    private var successHandle: SuccessHandle<V>?
    private var failureHandles = [FailureHandle]()
    private var finallyHandle: FinallyHandle?

    // MARK: - Initializer

    public init(value: V) {
        self.value = value
        error = nil
    }

    public init(error: AppError) {
        self.error = error
        value = nil
    }
    
    // MARK: - Public Methods

    public func success(_ handle: @escaping SuccessHandle<V>) {
        successHandle = handle
    }

    public func failure(_ handle: @escaping FailureHandle) {
        failureHandles.append(handle)
    }

    public func finally(_ handle: @escaping FinallyHandle) {
        finallyHandle = handle
    }

    public func execute(_ completion: ResourceCompletion<V>) {
        completion(self)

        if let success = value, let handle = successHandle {
            handle(success)
        } else if let failure = error {
            var stopHandlingErrors = false

            _ = failureHandles.first { handle in
                handle(failure) {
                    stopHandlingErrors = true
                }
                return stopHandlingErrors
            }
        }

        guard let finally = finallyHandle else { return }
        finally()
    }
}
