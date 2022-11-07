//
//  UsersResponse.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 02.11.22.
//

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
