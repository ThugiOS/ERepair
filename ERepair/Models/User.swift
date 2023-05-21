//
//  User.swift
//  ERepair
//
//  Created by Никитин Артем on 21.04.23.
//

import Foundation

struct User {
    let username: String
    let email: String
    let userUID: String
}

struct UserContent: Codable, Identifiable {
    var id: String
    var email: String?
}
