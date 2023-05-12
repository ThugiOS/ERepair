//
//  OrderStatus.swift
//  ERepair
//
//  Created by Никитин Артем on 28.04.23.
//

import UIKit
import FirebaseDatabaseSwift

struct OrderStatus: Codable {
    var id: UUID
    var from: String
    var to: String
    var content: String
    var date: Date
}
