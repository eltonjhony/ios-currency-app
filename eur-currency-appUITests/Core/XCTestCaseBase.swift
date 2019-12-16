//
//  XCTestCaseBase.swift
//  eur-currency-appUITests
//
//  Created by Elton Jhony Romao de Oliveira on 16/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import XCTest

class XCTestCaseBase: BaseSnapshotTestCase {

    let httpStub = SwifterHttpStub()
    let app = XCUIApplication()

    // MARK: - Overrides

    override func setUp() {
        super.setUp()
        app.launchArguments = ["system-under-test"]
        httpStub.startWebServer()
        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
        httpStub.stopWebServer()
        app.terminate()
    }

    // MARK: - Public Methods
    
    func waitForElementExists(_ element: XCUIElement, timeout: TimeInterval = 20.0, file: StaticString = #file, line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == 1")

        expectation(for: predicate, evaluatedWith: element)

        waitForExpectations(timeout: timeout) { error in
            guard let unwrappedError = error else { return }
            XCTFail("Wait for element exists (\(element)) - Fail: \(unwrappedError.localizedDescription)", file: file, line: line)
        }
    }

    func verifySnapshotView(delay: TimeInterval = 0, tolerance: CGFloat = 0, identifier: String = "", file: StaticString = #file, line: UInt = #line, framesToRemove: [CGRect] = []) {
        sleepTest(for: delay)

        var image: UIImage? = app.screenshot().image
        image = image?.removeStatusBar()

        if !framesToRemove.isEmpty {
            image = image?.addImageWithFrame(frames: framesToRemove) ?? UIImage()
        }

        folderName = customFolderName(file: file)
        let customIdentifier = "\(identifier)_\(UIDevice.current.name.replacingOccurrences(of: " ", with: ""))"
        FBSnapshotVerifyView(UIImageView(image: image), identifier: customIdentifier, perPixelTolerance: 0.005, overallTolerance: tolerance, file: file, line: line)
    }

    func getAppBarFrame() -> [CGRect] {
        var framesToRemove: [CGRect] = []
        framesToRemove.append(CGRect(x: 0, y: -7, width: 414.0, height: 75.0))
        return framesToRemove
    }

}

