//
//  BaseSnapshotTestCase.swift
//  eur-currency-appUITests
//
//  Created by Elton Jhony Romao de Oliveira on 16/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import FBSnapshotTestCase
import XCTest

class BaseSnapshotTestCase: FBSnapshotTestCase {

    // MARK: - Public methods

    func verifySnapshotView(delay: TimeInterval = 1.0, tolerance: CGFloat = 0, identifier: String = "", file: StaticString = #file, line: UInt = #line, framesToRemove: [CGRect] = [], view: @escaping () -> UIView?) {
        sleepTest(for: delay)

        guard let view = view() else {
            XCTFail("could not fetch view", file: file, line: line)
            return
        }

        var image = view.asImage()

        if !framesToRemove.isEmpty {
            image = image.addImageWithFrame(frames: framesToRemove) ?? UIImage()
        }

        folderName = customFolderName(file: file)
        let customIdentifier = "\(identifier)_\(UIDevice.current.name.replacingOccurrences(of: " ", with: ""))"
        FBSnapshotVerifyView(UIImageView(image: image), identifier: customIdentifier, perPixelTolerance: 0.005, overallTolerance: tolerance, file: file, line: line)
    }

    func sleepTest(for delay: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        guard delay > 0 else { return }
        let delayExpectation = XCTestExpectation(description: "failed to wait for " + String(delay))
        delayExpectation.assertForOverFulfill = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            delayExpectation.fulfill()
        }
        wait(for: [delayExpectation], timeout: 1 + delay)
    }

    func prepareStoryBoardView(_ targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            UIApplication.shared.keyWindow?.addSubview(viewController.view)
        }
    }

    func customFolderName(file: StaticString) -> String {
        let fileName = String(describing: type(of: self))
        let methodName: String = invocation?.selector.description ?? ""
        return "\(fileName)/\(methodName)"
    }

    // MARK: - Private methods

    private func cleanIdentifier(identifier: String) -> String {
        var deviceName = UIDevice.current.name

        if deviceName.contains("Clone") {
            for index in 0 ... 6 {
                deviceName = deviceName.replacingOccurrences(of: "Clone \(index) of", with: "")
            }
        }

        deviceName = deviceName.replacingOccurrences(of: " ", with: "")

        return "\(identifier)_\(deviceName)"
    }

}

