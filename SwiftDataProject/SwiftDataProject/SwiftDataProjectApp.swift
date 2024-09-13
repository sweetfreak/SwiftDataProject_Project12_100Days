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
        //Don't need the Job.self model because it's used in the User model, so it'll do it automatically!
    }
}
