//
//  UserDetailResponse.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 02.11.22.
//

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable, Equatable {
    let data: User
    let support: Support
}
