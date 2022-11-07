//
//  CreateViewModel.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 05.11.22.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    @Published var person = NewPerson()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    private let validator = CreateValidator()
    
    func create() {
        state = .submitting
        
        do {
            try validator.validate(person)
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(person)
            
            NetworkingManager
                .shared
                .request(methodType: .POST(data: data),
                         "https://reqres.in/api/users") { [weak self] res in
                    DispatchQueue.main.async {
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let error):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        if let networkingError = error as? NetworkingManager.NetworkingError {
                            self?.error = .networkingError(error: networkingError)
                        }
                    }
                }
            }
        } catch {
            self.state = .unsuccessful
            self.hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = .validation(error: validationError)
            }
        }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}

extension CreateViewModel {
    enum FormError: LocalizedError {
        case networkingError(error: LocalizedError)
        case validation(error: LocalizedError)
    }
}

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networkingError(let error),
            .validation(let error):
            return error.errorDescription
        }
    }
}
