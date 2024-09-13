//
//  User.swift
//  SwiftDataProject
//
//  Created by Jesse Sheehan on 9/9/24.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]() //need the parentheses to initialize it (make it for the first time)
    //Even though this jobs array wasn't here originally, because it's a new parentheses, it'll update - perform a migration - automatically
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
