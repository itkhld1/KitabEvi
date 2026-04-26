//
//  Models.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import Foundation

// user model
enum UserRole {
    case admin
    case customer
}

struct User {
    let username: String
    let role: UserRole
}

// book model
struct Book: Identifiable {
    let id = UUID()
    var title: String
    var author: String
    var price: Double
    var imageName: String
}

// analytics model
struct Stat: Identifiable {
    let id = UUID()
    let month: String
    let amount: Double
}
