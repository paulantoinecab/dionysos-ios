//
//  Order.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 05/10/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct OrderFood: Codable {
    let id: UUID
    let quantity: Int
}

typealias OrderFoods = [OrderFood]

struct Order: Codable {
    let table: Table
    let foods: OrderFoods
    
    enum CodingKeys: String, CodingKey {
        case table
        case foods
    }
}
