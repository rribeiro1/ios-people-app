//
//  PeopleViewModelSuccessTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class PeopleViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManageable!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    func test_with_successful_response_users_array_is_set() async throws {
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        await vm.fetchUsers()
        
        XCTAssertEqual(vm.users.count, 6, "Should be 6 users withing our data array")
    }
    
    func test_with_successful_paginated_response_users_array_is_set() async throws {
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        defer {
            XCTAssertFalse(vm.isFetching, "The view model shouldn't be fetching any data.")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "Should be 6 users within our data array")
        XCTAssertEqual(vm.page, 1, "The page should be 1")
        
        await vm.fetchNextSetOfUsers()
        XCTAssertEqual(vm.users.count, 12, "Should be 12 users within our data array")
        XCTAssertEqual(vm.page, 2, "The page should be 2")
    }
    
    func test_with_reset_called_values_is_reset() async throws {
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "Should be 6 users within our data array")

        await vm.fetchNextSetOfUsers()
        XCTAssertEqual(vm.users.count, 12, "Should be 12 users within our data array")
        XCTAssertEqual(vm.page, 2, "The page should be 2")

        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "Should be 6 users within our data array")
        XCTAssertEqual(vm.page, 1, "The page should be 1")
        XCTAssertEqual(vm.totalPages, 2, "The total pages should be 2")
        XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
    }
    
    func test_with_last_user_func_returns_true() async {
        await vm.fetchUsers()
        var lastLoadedUser = vm.users.last!
        XCTAssertTrue(vm.hasReachedEnd(of: lastLoadedUser))
        
        await vm.fetchUsers()
        lastLoadedUser = vm.users.last!
        XCTAssertTrue(vm.hasReachedEnd(of: lastLoadedUser))
    }
}
