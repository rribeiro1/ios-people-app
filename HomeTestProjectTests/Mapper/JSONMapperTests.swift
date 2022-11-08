//
//  JSONMapperTests.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 08.11.22.
//

import Foundation
import XCTest
@testable import HomeTestProject

class JSONMapperTests: XCTestCase {
    
    func test_with_valid_json_successfully_decodes() {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self))
        
        let userResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        XCTAssertNotNil(userResponse, "User response shouldn't be nil")
        XCTAssertEqual(userResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(userResponse?.perPage, 6, "Number per page should be 6")
        XCTAssertEqual(userResponse?.total, 12, "Total should be 12")
        XCTAssertEqual(userResponse?.totalPages, 2, "Total page should be 2")

        let firstPerson = userResponse?.data.first
        XCTAssertEqual(firstPerson?.id, 1)
        XCTAssertEqual(firstPerson?.email, "george.bluth@reqres.in")
        XCTAssertEqual(firstPerson?.firstName, "George")
        XCTAssertEqual(firstPerson?.lastName, "Bluth")
        XCTAssertEqual(firstPerson?.avatar, "https://reqres.in/img/faces/1-image.jpg")
    }
    
    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self))
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents)
        }
    }
    
    func test_with_invalid_file_name_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "Anything", type: UsersResponse.self))
        do {
            _ = try StaticJSONMapper.decode(file: "Anything", type: UsersResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents)
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self), "An error should be thrown")
        
        do {
            _ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self)
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong type of error, expecting a system decoding error")
            }
        }
    }
}
