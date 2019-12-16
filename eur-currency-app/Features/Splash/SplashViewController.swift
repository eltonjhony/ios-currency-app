//
//  SplashViewController.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 12/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

class SplashViewController: UIBaseViewController {
    
    var viewModel: CotationViewModelProtocol?
    var coordinatorDelegate: SplashViewControllerProtocol?

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindUI()
        loadInitialCotation()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.arrange(target: uiActivityIndicator)
    }

    private func bindUI() {
        viewModel?.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .prepare:
                break
            case .loading:
                self.uiActivityIndicator.startAnimating()
            case .success:
                self.uiActivityIndicator.stopAnimating()
                self.handleSuccess(self.viewModel?.cotations)
            case .error:
                self.uiActivityIndicator.stopAnimating()
                if let error = self.viewModel?.error {
                    print("An error occured: \(error)")
                }
            }
        }
    }

    private func loadInitialCotation() {
        viewModel?.fetchEurCotation(referenceValue: 1.0)
    }

    private func handleSuccess(_ cotations: [CotationView]?) {
        coordinatorDelegate?.initialLoadDidFinish(with: cotations)
    }
}

