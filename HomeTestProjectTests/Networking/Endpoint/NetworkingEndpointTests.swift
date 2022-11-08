//
//  NetworkingEndpointTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 08.11.22.
//

import XCTest
@testable import HomeTestProject

final class NetworkingEndpointTests: XCTestCase {
    
    func test_with_people_endpoint_request_is_valid() {
        let endpoint = Endpoint.people(page: 1)
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertEqual(endpoint.queryItems, ["page": "1"], "The query items should be page:1")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=3")
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        let endpoint = Endpoint.detail(id: 1)
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/1", "The path should be /api/users/1")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertNil(endpoint.queryItems, "Query items should be null")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/1?delay=3")
    }
    
    func test_with_create_endpoint_request_is_valid() {
        let endpoint = Endpoint.create(submissionData: nil)
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
        XCTAssertNil(endpoint.queryItems, "Query items should be null")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=3")
    }
}
