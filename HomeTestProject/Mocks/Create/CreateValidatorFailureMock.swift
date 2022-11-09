//
//  CreateValidatorFailureMock.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

#if DEBUG
import Foundation

struct CreateValidatorFailureMock: CreateValidatable {
    func validate(_ person: HomeTestProject.NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}
#endif
