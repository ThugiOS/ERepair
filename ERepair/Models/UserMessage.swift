//
//  UserMessage.swift
//  ERepair
//
//  Created by Никитин Артем on 21.05.23.
//

import Foundation

struct UserMessage: Codable, Identifiable {
    var id: UUID
    var from: String
    var to: String
    var content: String
    var date: Date
}
