//
//  NetworkingManagerUserDetailsResponseFailureMock.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

#if DEBUG
import Foundation

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManageable {
    func request<T>(session: URLSession, _ endpoint: HomeTestProject.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    func request(session: URLSession, _ endpoint: HomeTestProject.Endpoint) async throws {}
}
#endif
