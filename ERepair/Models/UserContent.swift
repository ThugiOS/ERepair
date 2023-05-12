//
//  UserContent.swift
//  ERepair
//
//  Created by Никитин Артем on 28.04.23.
//

import UIKit
import FirebaseDatabaseSwift

struct UserContent: Codable, Identifiable {
    var id: String
    var name: String
    var email: String?
}
