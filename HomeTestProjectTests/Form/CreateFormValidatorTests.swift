//
//  CreateFormValidatorTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 08.11.22.
//

import XCTest
@testable import HomeTestProject

final class CreateFormValidatorTests: XCTestCase {
    
    private var validator: CreateValidator!
    
    override func setUp() {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }
    
    func test_throws_exception_when_first_name_is_empty() {
        let person = NewPerson()
        XCTAssertThrowsError(try validator.validate(person))
        XCTAssertThrowsValidatorError(for: person, expected: .invalidFirstName, field: "First name")
    }
    
    func test_throws_exception_when_last_name_is_empty() {
        let person = NewPerson(firstName: "Rafael")
        XCTAssertThrowsError(try validator.validate(person))
        XCTAssertThrowsValidatorError(for: person, expected: .invalidLastName, field: "Last name")
    }
    
    func test_throws_exception_when_job_is_empty() {
        let person = NewPerson(firstName: "Rafael", lastName: "Ribeiro")
        XCTAssertThrowsError(try validator.validate(person))
        XCTAssertThrowsValidatorError(for: person, expected: .invalidJob, field: "Job")
    }
    
    func test_does_not_throw_exception_when_user_is_valid() {
        let person = NewPerson(firstName: "Rafael", lastName: "Ribeiro", job: "Engineer")
        XCTAssertNoThrow(try validator.validate(person))
    }
    
    private func XCTAssertThrowsValidatorError(
        for person: NewPerson,
        expected: CreateValidator.CreateValidatorError,
        field: String
    ) {
        do {
            try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, expected, "Expecting an error where we have an invalid \(field)")
        }
    }
}
