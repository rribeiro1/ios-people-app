//
//  PeopleViewModelFailureTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class PeopleViewModelFailureTests: XCTestCase {
    private var networkingMock: NetworkingManageable!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseFailureMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_error_is_handled() async {
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        await vm.fetchUsers()
        
        XCTAssertTrue(vm.hasError, "View model should have an error")
        XCTAssertNotNil(vm.error, "View model error should be set")
    }
}
