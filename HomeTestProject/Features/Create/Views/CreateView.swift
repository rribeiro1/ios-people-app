//
//  CreateView.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 04.11.22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm: CreateViewModel
    private let successfulAction: () -> Void
    
    init(successfulAction: @escaping () -> Void) {
        self.successfulAction = successfulAction
        
        #if DEBUG
        if UITestingHelper.isUITesting {
            let mock: NetworkingManageable = UITestingHelper.isCreateNetworkingSuccessful
            ? NetworkingManagerCreateSuccessMock()
            : NetworkingManagerCreateFailureMock()
            _vm = StateObject(wrappedValue: CreateViewModel(networkingManager: mock))
        } else {
            _vm = StateObject(wrappedValue: CreateViewModel())
        }
        #else
            _vm = StateObject(wrappedValue: CreateViewModel())
        #endif
    }
    
    var body: some View {
        Form {
            
            Section {
                firstname
                lastname
                job
            } footer: {
                if case .validation(let error) = vm.error, let errorDescription = error.errorDescription {
                    Text(errorDescription).foregroundColor(.red)
                }
            }
            
            Section {
                submit
            }
        }
        .disabled(vm.state == .submitting)
        .navigationTitle("Create")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                done
            }
        }
        .onChange(of: vm.state) { formState in
            if formState == .successful {
                dismiss()
                successfulAction()
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {}
        .overlay {
            if vm.state == .submitting {
                ProgressView()
            }
        }
        .embedInNavigation()
        
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView {}
            .embedInNavigation()
    }
}

private extension CreateView {
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
        .accessibilityIdentifier("doneButton")
    }
    
    var firstname: some View {
        TextField("First name", text: $vm.person.firstName)
            .focused($focusedField, equals: .firstName)
            .accessibilityIdentifier("firstNameTextField")
    }
    
    var lastname: some View {
        TextField("Last name", text: $vm.person.lastName)
            .focused($focusedField, equals: .lastName)
            .accessibilityIdentifier("lastNameTextField")
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusedField, equals: .job)
            .accessibilityIdentifier("jobTextField")
    }
    
    var submit: some View {
        Button("Submit") {
            focusedField = nil
            Task {
                await vm.create()
            }
        }
        .accessibilityIdentifier("submitButton")
    }
}
