//
//  NetworkingManagerUserDetailsResponseSuccessMock.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import Foundation
@testable import HomeTestProject

class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManageable {
    func request<T>(session: URLSession, _ endpoint: HomeTestProject.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: HomeTestProject.Endpoint) async throws {}
}
