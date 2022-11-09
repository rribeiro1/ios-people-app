//
//  DetailsViewModelFailureTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class DetailsViewModelFailureTests: XCTestCase {

    private var networkingManager: NetworkingManageable!
    private var vm: DetailViewModel!
    
    override func setUp() {
        networkingManager = NetworkingManagerUserDetailsResponseFailureMock()
        vm = DetailViewModel(networkingManager: networkingManager)
    }
    
    override func tearDown() {
        networkingManager = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_error_is_handled() async {
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        }
        
        await vm.fetchDetails(for: 1)
        
        XCTAssertTrue(vm.hasError, "View model should have an error")
        XCTAssertNotNil(vm.error, "View model error should be set")
    }
}
