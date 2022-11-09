//
//  CreateViewModelFailureTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class CreateViewModelFailureTests: XCTestCase {

    private var networkingManager: NetworkingManageable!
    private var validator: CreateValidatable!
    private var vm: CreateViewModel!
    
    override func setUp() {
        validator = CreateValidatorSuccessMock()
        networkingManager = NetworkingManagerCreateFailureMock()
        vm = CreateViewModel(networkingManager: networkingManager, createValidator: validator)
    }
    
    override func tearDown() {
        validator = nil
        networkingManager = nil
        vm = nil
    }
    
    func test_with_successful_response_submission_state_is_successful() async throws {
        XCTAssertNil(vm.state, "The view model view state should be nil initially")
        defer { XCTAssertEqual(vm.state, .unsuccessful, "The view model state should be unsuccessful") }
        
        await vm.create()
        
        XCTAssertNotNil(vm.error, "The view model error shoud not be nil")
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertEqual(vm.error, .networkingError(error: NetworkingManager.NetworkingError.invalidUrl), "The view model error should be networking error with invalid URL")
    }
}
