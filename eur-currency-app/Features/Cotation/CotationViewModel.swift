//
//  SplashViewModel.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation

protocol CotationViewModelProtocol {

    var state: Dynamic<ViewControllerState> { get }
    var cotations: [CotationView] { get }
    var error: String? { get }

    func fetchEurCotation(referenceValue: Float)
    func setCotations(_ cotations: [CotationView]?)
}

class CotationViewModel: CotationViewModelProtocol {

    var state: Dynamic<ViewControllerState> = Dynamic(.prepare)
    var cotations: [CotationView] = []
    var error: String?

    private let interactor: CotationInteractorProtocol?

    // MARK: - Initialize

    init(interactor: CotationInteractorProtocol?) {
        self.interactor = interactor
    }

    // MARK: - Public Methods

    func fetchEurCotation(referenceValue: Float) {
        state.value = .loading
        interactor?.fetchEurCotation(referenceValue) { [weak self] (cotations, error) in
            guard let self = self else { return }
            self.handleSuccess(cotations)
            self.handleError(error)
        }
    }
    
    func setCotations(_ cotations: [CotationView]?) {
        if let cotations = cotations {
            self.cotations = cotations
        }
    }

    // MARK: - Private Methods

    private func handleSuccess(_ cotations: [CotationView]?) {
        if let cotations = cotations {
            self.cotations = cotations
            self.state.value = .success
        }
    }

    private func handleError(_ error: String?) {
        if let error = error {
            self.error = error
            self.state.value = .error
        }
    }

}
