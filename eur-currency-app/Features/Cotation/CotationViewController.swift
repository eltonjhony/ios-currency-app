//
//  CotationViewController.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

class CotationViewController: UIBaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var baseRateTextView: UITextField!
    @IBOutlet weak var baseCountryImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var baseCurrencySymbol: UILabel!

    var viewModel: CotationViewModelProtocol?

    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureTableView()
        bindUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.arrange(target: uiActivityIndicator)
        baseRateTextView.addActionButton(target: self, text: LocalizationKeys.closeLabel.value,
                                         style: .done,
                                         action: #selector(closeAction))
        baseRateTextView.addSpaceItem(target: self)
        baseRateTextView.addActionButton(target: self, text: LocalizationKeys.calculateLabel.value,
                                         style: .done,
                                         action: #selector(calculateCotationAction))
        baseRateTextView.isAccessibilityElement = true
        baseRateTextView.accessibilityIdentifier = Accessibility.CotationView.baseRateTextFieldIdentifier
        baseCurrencySymbol.text = LocalizationKeys.euroSymbol.value
        baseCountryImage.loadFromUrl(ImageHelper.buildCountryFlag())
        baseCountryImage.round()
        titleLabel.text = LocalizationKeys.appTitle.value
        titleLabel.largeBold()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(cellType: CotationCell.self, bundle: Bundle.local)
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
                self.tableView.reloadData()
            case .error:
                self.uiActivityIndicator.stopAnimating()
                if let error = self.viewModel?.error {
                    print("An error occured: \(error)")
                }
            }
        }
    }

}

extension CotationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(with: CotationCell.self, for: indexPath) else { return UITableViewCell() }
        cell.setupCell(cotation: viewModel?.cotations[indexPath.row], index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cotations.count ?? 0
    }

}

extension CotationViewController {

    @objc func calculateCotationAction() {
        guard let value = baseRateTextView.text?.floatValue else {
            return
        }
        viewModel?.fetchEurCotation(referenceValue: value)
    }

    @objc func closeAction() {
        view.endEditing(true)
    }

}
