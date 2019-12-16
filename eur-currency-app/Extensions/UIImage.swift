//
//  UIImage.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 14/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {

    func loadFromUrl(_ urlString: String) {
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }

        ImageHelper.load(url: urlString) { (_ response: () throws -> (HTTPURLResponse, Data)) in
            do {

                let (_, data) = try response()
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }

            } catch {
                print("Error fetching images: \(error)")
            }
        }
        
    }

    func round() {
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
    }
}
