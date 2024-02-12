//
//  BuildUpUITests.swift
//  BuildUpUITests
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import XCTest

final class BuildUpUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    @MainActor override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    @MainActor func testTakeSnapshots() {
        snapshot("SubdomainViewController")
//        app.buttons["scanMe"].tap()
//        snapshot("LoginViewController")
//        app.buttons["Skip"].tap()
//        snapshot("HomeViewController")

//        let coordinate = app.tables.otherElements.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5))
//
//        for _ in 0...5 {
//            coordinate.tap()
//        }
//        snapshot("2-StepperIncremented")
//        app.navigationBars.firstMatch.buttons.firstMatch.tap()
//        snapshot("3-Alert")
//        app.buttons["Skip"].tap()
//        snapshot("HomeViewController")
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {

    func tapElement() {
        if isHittable {
            tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
}
