//
//  CreateValidatorSuccessMock.swift
//  HomeTestProjectTests
//
//  Created by Rafael Ribeiro on 09.11.22.
//

#if DEBUG
import Foundation

struct CreateValidatorSuccessMock: CreateValidatable {
    func validate(_ person: HomeTestProject.NewPerson) throws {}
}
#endif
