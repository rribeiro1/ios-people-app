//
//  CreateScreenUIValidTests.swift
//  HomeTestProjectUITests
//
//  Created by Rafael Ribeiro on 10.11.22.
//

import XCTest

final class CreateScreenUIValidTests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-people-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_when_create_is_tapped_create_view_is_presented() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        XCTAssertTrue(app.navigationBars["Create"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["doneButton"].exists)
        XCTAssertTrue(app.textFields["firstNameTextField"].exists)
        XCTAssertTrue(app.textFields["lastNameTextField"].exists)
        XCTAssertTrue(app.textFields["jobTextField"].exists)
        XCTAssertTrue(app.buttons["submitButton"].exists)
    }
    
    func test_when_done_is_tapped_create_view_is_dismissed() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        let doneButton = app.buttons["doneButton"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        
        XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5))
    }
}
