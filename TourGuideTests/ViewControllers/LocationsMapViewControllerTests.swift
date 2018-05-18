//
//  LocationsMapViewControllerTests.swift
//  TourGuideTests
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import XCTest

class LocationsMapViewControllerTests: XCTestCase {
    
    var locations: [Location]?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let locationContent = LocationContent.createInstanceFromFile("Locations") as? LocationContent
        XCTAssertNotNil(locationContent)
        XCTAssertNotNil(locationContent?.locations)
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
