//
//  DetailsViewModelSuccessTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import XCTest
@testable import HomeTestProject

final class DetailsViewModelSuccessTests: XCTestCase {
    
    private var networkingManager: NetworkingManageable!
    private var vm: DetailViewModel!
    
    override func setUp() {
        networkingManager = NetworkingManagerUserDetailsResponseSuccessMock()
        vm = DetailViewModel(networkingManager: networkingManager)
    }
    
    override func tearDown() {
        networkingManager = nil
        vm = nil
    }
    
    func test_with_successful_response_user_info_is_set() async throws {
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data.")
        }
        
        await vm.fetchDetails(for: 1)
        
        XCTAssertNotNil(vm.userInfo, "User info should not be nil")
        
        let userDetailsData = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
        XCTAssertEqual(vm.userInfo, userDetailsData)
    }
    
}
