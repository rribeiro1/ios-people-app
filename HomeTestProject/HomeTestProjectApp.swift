//
//  HomeTestProjectApp.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 02.11.22.
//

import SwiftUI

@main
struct HomeTestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}
