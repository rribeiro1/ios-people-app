//
//  CreateValidator.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 07.11.22.
//

import Foundation

struct CreateValidator {
    func validate(_ person: NewPerson) throws {
        if person.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if person.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if person.job.isEmpty {
            throw CreateValidatorError.invalidJob
        }
    }
}

extension CreateValidator {
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidJob
    }
}

extension CreateValidator.CreateValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return "First name can't be blank"
        case .invalidLastName:
            return "Last name can't be blank"
        case .invalidJob:
            return "Job can't be blank"
        }
    }
}
