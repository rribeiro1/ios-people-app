//
//  NetworkingManagerUserDetailsFailureResponseMock.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import Foundation
@testable import HomeTestProject

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManageable {
    func request<T>(session: URLSession, _ endpoint: HomeTestProject.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    func request(session: URLSession, _ endpoint: HomeTestProject.Endpoint) async throws {}
}
