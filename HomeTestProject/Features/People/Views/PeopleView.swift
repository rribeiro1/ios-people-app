//
//  PeopleView.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 02.11.22.
//

import SwiftUI

struct PeopleView: View {
    
    @StateObject private var vm = PeopleViewModel()
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false

    private let columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.users, id: \.id) { item in
                                NavigationLink {
                                    DetailView(userId: item.id)
                                } label: {
                                    PersonItemView(user: item)
                                }
                            }
                        }
                    }.padding()
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                vm.fetchUsers()
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchUsers()
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}

private extension PeopleView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus.font(.system(.headline, design: .rounded).bold())
        }
        .disabled(vm.isLoading)
    }
}
