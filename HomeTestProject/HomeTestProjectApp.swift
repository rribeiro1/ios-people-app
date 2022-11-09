//
//  HomeTestProjectApp.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 02.11.22.
//

import SwiftUI

@main
struct HomeTestProjectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("🧑🏽‍🏭 is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
