//
//  TableRestaurant.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 19/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
struct TableRestaurant: Codable {
    let table: Table
    let restaurant: Restaurant

    enum CodingKeys: String, CodingKey {
        case table = "Table"
        case restaurant = "Restaurant"
    }
}
