//
//  Models.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 02.11.22.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
