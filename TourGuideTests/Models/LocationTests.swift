//
//  LocationTests.swift
//  TourGuideTests
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import XCTest

class LocationTests: XCTestCase {
    
    var location: Location?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var dictionary: [String: Any]? = nil
        XCTAssertNil(Location.createInstanceFrom(dictionary))
        dictionary = ["name": "Milsons Point", "lat": -33.850750, "lng": 151.212519]
        location = Location.createInstanceFrom(dictionary) as? Location
        XCTAssertNotNil(Location.createInstanceFrom(dictionary))
        XCTAssertNotNil(location?.getKeyChainData())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstanceMethods() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertNil(Location.returnSelectedAnnotation(annotation: nil, locations: [location!]))
        XCTAssertNotNil(Location.returnSelectedAnnotation(annotation: location?.addAnnotation(), locations: [location!]))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
