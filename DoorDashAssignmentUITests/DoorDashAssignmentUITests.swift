//
//  DoorDashAssignmentUITests.swift
//  DoorDashAssignmentUITests
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import XCTest

class DoorDashAssignmentUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddressInTextField() {
        XCUIDevice.shared.orientation = .portrait
        
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Choose an Address").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.tap()
        app.buttons["Confirm Address"].tap()
        app.navigationBars["UITabBar"].buttons["Choose an Address"].tap()
    }
    
}
