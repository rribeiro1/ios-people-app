//
//  CreateViewModelSuccessTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class CreateViewModelSuccessTests: XCTestCase {
    
    private var networkingManager: NetworkingManageable!
    private var validator: CreateValidatable!
    private var vm: CreateViewModel!
    
    override func setUp() {
        validator = CreateValidatorSuccessMock()
        networkingManager = NetworkingManagerCreateSuccessMock()
        vm = CreateViewModel(networkingManager: networkingManager, createValidator: validator)
    }
    
    override func tearDown() {
        validator = nil
        networkingManager = nil
        vm = nil
    }
    
    func test_with_successful_response_submission_state_is_successful() async throws {
        XCTAssertNil(vm.state, "The view model view state should be nil initially")
        defer { XCTAssertEqual(vm.state, .successful, "The view model state should be successful") }
        
        await vm.create()
    }
}
