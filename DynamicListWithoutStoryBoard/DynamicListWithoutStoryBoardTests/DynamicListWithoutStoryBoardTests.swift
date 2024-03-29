//
//  DynamicListWithoutStoryBoardTests.swift
//  DynamicListWithoutStoryBoardTests
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import XCTest
@testable import DynamicListWithoutStoryBoard

class DynamicListWithoutStoryBoardTests: XCTestCase {

    var viewModel: HomeViewModel!
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    
    func testSuccessGettingList() {
        let promise = expectation(description: "downloaded successfully")
        viewModel.getList { (state) in
            switch state {
            case .Success(_):
                promise.fulfill()
            default:
                XCTFail("download failed")
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    //
    
    func testNoInternetConnection() {
        let errorMsg = "The Internet connection appears to be offline."
        let promise = expectation(description: "The Internet connection appears to be offline")
        viewModel.getList { (state) in
            switch state {
            case .Failed(let msg):
                if msg == errorMsg {
                    promise.fulfill()
                }
            case .Success(_):
                promise.fulfill()
            default:
                XCTFail("download failed")
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
