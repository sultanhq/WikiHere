//
//  WikiHereTests.swift
//  WikiHereTests
//
//  Created by Rob Adams on 16/02/2017.
//  Copyright © 2017 Rob Adams. All rights reserved.
//

import XCTest
@testable import WikiHere

class WikiHereTests: XCTestCase {
    
    let gps = GPS()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testsWikiHereButton() {
        let result = gps.Location()
        XCTAssertEqual(result, "London")
    }
}
