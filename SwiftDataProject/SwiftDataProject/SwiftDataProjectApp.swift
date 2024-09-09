//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Jesse Sheehan on 9/9/24.
//
import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
