//
//  WikiHereUITest.swift
//  WikiHere
//
//  Created by Rob Adams on 16/02/2017.
//  Copyright © 2017 Rob Adams. All rights reserved.
//

import XCTest

class WikiHereUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocationLabelChange() {
        let app = XCUIApplication()
        let wikiHereButton = app.buttons["wikiHere"]
        let locationLabel =  app.staticTexts["locationLabel"]
        let result = locationLabel.staticTexts
        wikiHereButton.tap()
        print (result.staticTexts)
        XCTAssert(app.staticTexts["Getting Location"].exists)
    }
    
//    func testsGetLocationFromVC() {
//        
//        XCTAssertEqual(location, ")
//    }

}
