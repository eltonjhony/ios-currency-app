//
//  UIImageTests.swift
//  eur-currency-appUITests
//
//  Created by Elton Jhony Romao de Oliveira on 16/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit
import XCTest

extension UIImage {
    func removeStatusBar() -> UIImage? {
        var frames: [CGRect] = []

        var rectangle = CGRect(x: size.width / 4, y: 0, width: (size.width / 4) * 3, height: UIApplication.shared.statusBarFrame.height)

        if rectangle.size.height >= 44 {
            rectangle.origin.x = 0
            let rectagleSize = CGSize(width: size.width / 8.5, height: rectangle.size.height)
            let batteryRectangle = CGRect(x: size.width - rectagleSize.width, y: rectangle.origin.y, width: rectagleSize.width, height: rectagleSize.height)
            frames.append(batteryRectangle)
        }
        frames.append(rectangle)
        return addImageWithFrame(frames: frames)
    }

    func addImageWithFrame(frames: [CGRect]) -> UIImage? {
        let imageSize = size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        draw(at: .zero)
        context.setFillColor(UIColor.black.cgColor)
        context.addRects(frames)
        context.drawPath(using: .fill)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
