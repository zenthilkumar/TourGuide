//
//  BaseViewControllerTests.swift
//  TourGuideTests
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import XCTest

class BaseViewControllerTests: XCTestCase {

    let baseViewController: BaseViewController = BaseViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLifeCycle() {
        
        XCTAssertNotNil(baseViewController.viewDidLoad(), "viewDidLoad called")
        XCTAssertNotNil(baseViewController.viewWillAppear(true), "View will Appear called")
    }
    
    func testDidReceiveMemoryWarningCallsSuper() {
        XCTAssertNotNil(baseViewController.didReceiveMemoryWarning(), "didReceiveMemoryWarning called")
        
    }
}
