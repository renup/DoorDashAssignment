//
//  DoorDashAssignmentUITests.swift
//  DoorDashAssignmentUITests
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import XCTest

class DoorDashAssignmentUITests: XCTestCase {
    
    func testAddressInTextField() {
        XCUIDevice.shared.orientation = .portrait
        
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Choose an Address").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.tap()
        app.buttons["Confirm Address"].tap()
        app.navigationBars["UITabBar"].buttons["Choose an Address"].tap()
    }
    
}
