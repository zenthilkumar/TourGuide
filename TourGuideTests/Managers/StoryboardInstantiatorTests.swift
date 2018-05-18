//
//  StoryboardInstantiatorTests.swift
//  TourGuideTests
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import XCTest

class StoryboardInstantiatorTests: XCTestCase {
    
    var storyboardInstantiator = StoryboardInstantiator()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstantiateViewController() {
        
        let mapViewController = storyboardInstantiator.instantiateViewController(storyboard: MapScreenStoryboard.LocationsMapViewController)
        XCTAssertNotNil(mapViewController)
        let listViewController = storyboardInstantiator.instantiateViewController(storyboard: MapScreenStoryboard.LocationsListViewController)
        XCTAssertNotNil(listViewController)
        let detailViewController = storyboardInstantiator.instantiateViewController(storyboard: MapScreenStoryboard.LocationDetailViewController)
        XCTAssertNotNil(detailViewController)
        storyboardInstantiator.instantiateWith(data: Location(), storyboard: MapScreenStoryboard.LocationsListViewController, navigationStyle: .Default)
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
