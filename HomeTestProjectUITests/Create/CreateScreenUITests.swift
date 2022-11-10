//
//  CreateScreenUITests.swift
//  HomeTestProjectUITests
//
//  Created by Rafael Ribeiro on 10.11.22.
//

import XCTest

final class CreateScreenUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success":"1",
            "-create-networking-success":"1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_valid_form_submission_is_successful() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        let firstName = app.textFields["firstNameTextField"]
        let lastName = app.textFields["lastNameTextField"]
        let jobTextField = app.textFields["jobTextField"]
        let submitButton = app.buttons["submitButton"]
        
        firstName.tap()
        firstName.typeText("Rafael")
        
        lastName.tap()
        lastName.typeText("Ribeiro")
        
        jobTextField.tap()
        jobTextField.typeText("iOS Developer")
        
        submitButton.tap()
        
        XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "There should be a navigation bar titlePeople")
    }
}
