//
//  CreateScreenFormValidationTest.swift
//  HomeTestProjectUITests
//
//  Created by Rafael Ribeiro on 10.11.22.
//

import XCTest

final class CreateScreenFormValidationTest: XCTestCase {
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
    
    func test_when_all_form_fields_are_empty_first_name_error_is_shown() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.exists)
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["First name can't be blank"].exists)
        alert.buttons["OK"].tap()
        
        XCTAssertTrue(app.staticTexts["First name can't be blank"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }
    
    func test_when_first_name_form_field_is_empty_first_name_error_is_shown() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        let lastNameTextField = app.textFields["lastNameTextField"]
        let jobTextField = app.textFields["jobTextField"]
        let submitButton = app.buttons["submitButton"]
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Rafael")
        
        jobTextField.tap()
        jobTextField.typeText("iOS Developer")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["First name can't be blank"].exists)
        alert.buttons["OK"].tap()
        
        XCTAssertTrue(app.staticTexts["First name can't be blank"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }
    
    func test_when_last_name_form_field_is_empty_first_name_error_is_shown() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        let firstName = app.textFields["firstNameTextField"]
        let jobTextField = app.textFields["jobTextField"]
        let submitButton = app.buttons["submitButton"]
        
        firstName.tap()
        firstName.typeText("Rafael")
        
        jobTextField.tap()
        jobTextField.typeText("iOS Developer")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["Last name can't be blank"].exists)
        alert.buttons["OK"].tap()
        
        XCTAssertTrue(app.staticTexts["Last name can't be blank"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }
    
    func test_when_job_form_field_is_empty_first_name_error_is_shown() {
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "Create button should be visible on the screen")
        
        createButton.tap()
        
        let firstName = app.textFields["firstNameTextField"]
        let lastName = app.textFields["lastNameTextField"]
        let submitButton = app.buttons["submitButton"]
        
        firstName.tap()
        firstName.typeText("Rafael")
        
        lastName.tap()
        lastName.typeText("Ribeiro")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["Job can't be blank"].exists)
        alert.buttons["OK"].tap()
        
        XCTAssertTrue(app.staticTexts["Job can't be blank"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }
}
