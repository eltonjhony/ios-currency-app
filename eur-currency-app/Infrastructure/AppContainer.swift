//
//  AppContainer.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 15/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import Swinject
import eur_currency_networking

protocol AppContainerProtocol {

    func setupDependencies()

    func provideRepositories()
    func provideInteractors()
    func provideViewModels()
    func provideViewControllers()
}

class AppContainer: AppContainerProtocol {

    let container: Container = {
        let container = Container()
        return container
    }()

    func setupDependencies() {
        provideRepositories()
        provideInteractors()
        provideViewModels()
        provideViewControllers()
    }

    func provideRepositories() {
        container.register(CotationRepositoryProtocol.self) { r in
            return CotationRepository(provider: HTTPProvider(configurationProtocol: HTTPProviderConfiguration()), fetchRequest: FetchEurCotationHTTPRequest())
        }
    }

    func provideInteractors() {
        container.register(CotationInteractorProtocol.self) { r in
            return CotationInteractor(repository: r.resolve(CotationRepositoryProtocol.self))
        }
    }

    func provideViewModels() {
        container.register(CotationViewModelProtocol.self) { r in
            return CotationViewModel(interactor: r.resolve(CotationInteractorProtocol.self))
        }
    }

    func provideViewControllers() {
        container.register(SplashViewController.self) { r in
            let viewController = SplashViewController.instantiate()
            viewController.viewModel = r.resolve(CotationViewModelProtocol.self)
            return viewController
        }
        container.register(CotationViewController.self) { r in
            let viewController = CotationViewController.instantiate()
            viewController.viewModel = r.resolve(CotationViewModelProtocol.self)
            return viewController
        }
    }
    
}
