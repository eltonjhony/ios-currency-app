//
//  CotationCoordinator.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit
import Swinject

class CotationCoordinator: Coordinator {

    private let container: Container
    private let presenter: UINavigationController
    
    var cotations: [CotationView]?

    // MARK: - Initialize

    init(container: Container, presenter: UINavigationController) {
        self.container = container
        self.presenter = presenter
    }

    // MARK: - Public Methods

    func start() {
        if let viewController = container.resolve(CotationViewController.self) {
            viewController.viewModel?.setCotations(cotations)
            
            presenter.pushViewController(viewController, animated: true)
        }
    }
}
