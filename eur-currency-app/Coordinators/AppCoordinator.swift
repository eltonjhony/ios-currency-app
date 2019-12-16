//
//  MainCoordinator.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 12/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit
import Swinject

protocol Coordinator {
    func start()
}

protocol SplashViewControllerProtocol {
    func initialLoadDidFinish(with cotations: [CotationView]?)
}

class AppCoordinator: Coordinator {

    private var container: Container
    private var presenter: UINavigationController

    // MARK: - Initialize

    init(container: Container, presenter: UINavigationController) {
        self.container = container
        self.presenter = presenter
    }

    // MARK: - Public Methods

    func start() {
        if let viewController = container.resolve(SplashViewController.self) {
            viewController.coordinatorDelegate = self

            presenter.setNavigationBarHidden(true, animated: true)
            presenter.pushViewController(viewController, animated: true)
        }
    }
}

extension AppCoordinator: SplashViewControllerProtocol {

    func initialLoadDidFinish(with cotations: [CotationView]?) {
        let cotationCoordinator = CotationCoordinator(container: container, presenter: presenter)
        cotationCoordinator.cotations = cotations
        cotationCoordinator.start()
    }
}
