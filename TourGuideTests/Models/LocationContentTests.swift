//
//  LocationContentTests.swift
//  TourGuideTests
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import XCTest

class LocationContentTests: XCTestCase {
    
    var locationContent: LocationContent?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let dictionary: [String: Any]? = ["name": "Milsons Point", "lat": -33.850750, "lng": 151.212519]
        locationContent = LocationContent.createInstanceFrom(dictionary) as? LocationContent
        XCTAssertNotNil(locationContent)
        XCTAssertTrue(locationContent?.locations?.isEmpty == false)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
