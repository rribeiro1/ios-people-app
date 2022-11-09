//
//  CreateViewModelValidationFailureTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class CreateViewModelValidationFailureTests: XCTestCase {
    
    private var networkingManager: NetworkingManageable!
    private var validator: CreateValidatable!
    private var vm: CreateViewModel!
    
    override func setUp() {
        validator = CreateValidatorFailureMock()
        networkingManager = NetworkingManagerCreateSuccessMock()
        vm = CreateViewModel(networkingManager: networkingManager, createValidator: validator)
    }
    
    override func tearDown() {
        validator = nil
        networkingManager = nil
        vm = nil
    }
    
    func test_with_invalid_submission_state_is_invalid() async throws {
        XCTAssertNil(vm.state, "The view model view state should be nil initially")
        defer { XCTAssertEqual(vm.state, .unsuccessful, "The view model state should be unsuccessful") }
        
        await vm.create()
        
        XCTAssertNotNil(vm.error, "The view model error shoud not be nil")
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertEqual(vm.error, .validation(error: CreateValidator.CreateValidatorError.invalidFirstName), "The view model error should be invalid first name")
    }
}
