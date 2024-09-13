//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Jesse Sheehan on 9/9/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
//  //Predicate converts this all into much longer, complex swift code!
//    @Query(filter: #Predicate<User> { user in
//        //user.name.contains("S") // CASE SENSITIVE!
//        //user.name.localizedStandardContains("S") && // NOT case sensitive
//        //user.city == "Los Angeles"
//        
//        //can also use "if" statements!
//        
//        if user.name.localizedStandardContains("S") {
//            if user.city == "Los Angeles" {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//        // YOU HAVE TO RETURN FALSE IN AN ELSE STATEMENT IN THIS SITUATION - you can't just put "return false" at the end of the block of code
//    }, sort: \User.name) var users: [User]
    
    
    var body: some View {
        NavigationStack {
//            List(users) { user in
//                    Text(user.name)
//            }
            //by changing this to a view instead of a list, we can show different lists of people - kind of an alternative to the query filtering outright
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
           
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    
                    //delete all existing user contexts in the model
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Andy Staub", city: "Avon-by-the-Sea", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Jamiesen Borak", city: "Los Angeles", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Melanie Asalde-Smith", city: "Yacinda", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Arthur Hickman", city: "Eugene", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
                
                Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showingUpcomingOnly.toggle()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}


// USE WITH EDITUSERVIEW
//struct ContentView: View {
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \User.name) var users: [User]
//   @State private var path = [User]()
//    
//    
//    var body: some View {
//        NavigationStack(path: $path) {
//            List(users) { user in
//                NavigationLink(value: user) {
//                    Text(user.name)
//                }
//            }
//            .navigationTitle("Users")
//            .navigationDestination(for: User.self) { user in
//            EditUserView(user: user)
//            }
//            .toolbar {
//                Button("Add User", systemImage: "plus") {
//                    let user = User(name: "", city: "", joinDate: .now)
//                    modelContext.insert(user)
//                    path = [user]
//                }
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
