//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Jesse Sheehan on 9/10/24.
//
import SwiftData
import SwiftUI

//NOTE: If a user is deleted, all their jobs are deleted too! If you want their jobs deleted, you'll have to delete their jobs separately or with another macro, called @Relationship(?), and use a cascade so it deletes everything with it. If there were a bunch of connected models, it could delete everything with it, too.


struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        
        List(users) { user in
            HStack {
                Text(user.name)
                Spacer()
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        //this doesn't make the users array, it makes the Query that makes the array.
        //The "_" underscore is how swift accesses the query that makes the array
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
    func addSample() {
        let user1 = User(name: "Max Cohen", city: "Brooklyn", joinDate: .now)
        let job1 = Job(name: "Make Dinner", priority: 2)
        let job2 = Job(name: "Make Bed", priority: 3)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
    
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
