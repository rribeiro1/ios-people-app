//
//  View.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 10.11.22.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}
