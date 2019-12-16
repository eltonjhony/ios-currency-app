//
//  CotationCell.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 13/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import Foundation
import UIKit

class CotationCell: UITableViewCell {

    @IBOutlet private weak var countryImage: UIImageView!
    @IBOutlet private weak var countryCode: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    func setupCell(cotation: CotationView?, index: Int) {
        if let cotation = cotation {
            countryImage.loadFromUrl(cotation.countryImageUrl)
            countryImage.round()
            countryCode.text = cotation.countryCode
            rateLabel.text = LocalizationKeys.currencySymbol.value + String(cotation.rate)
        }
    }
}
