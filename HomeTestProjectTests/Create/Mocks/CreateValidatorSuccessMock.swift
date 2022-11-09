//
//  CreateValidatorSuccessMock.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

import Foundation
@testable import HomeTestProject

struct CreateValidatorSuccessMock: CreateValidatable {
    func validate(_ person: HomeTestProject.NewPerson) throws {}
}
