//
//  DynamicListWithoutStoryBoardUITests.swift
//  DynamicListWithoutStoryBoardUITests
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import XCTest

class DynamicListWithoutStoryBoardUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScrollToTableLastCell() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        //let promise = expectation(description: "table scrolled successfully")
        let table = app.descendants(matching: .table).firstMatch
        //let count = table.cells.count
        //print("Count \(count)")
        sleep(15)
       guard let lastCell = table.cells.allElementsBoundByIndex.last else {
            XCTFail("No tablecell found")
            return
        }
        let MAX_SCROLLS = 10
        var count = 0
        while lastCell.isHittable == false && count < MAX_SCROLLS {
            app.swipeUp()
            count += 1
            
        }
        //promise.fulfill()
        //wait(for: [promise], timeout: 15)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
