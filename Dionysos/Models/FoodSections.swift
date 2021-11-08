//
//  FoodSections.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct FoodSection: Codable {
    let id: UUID
    let name: String
    let food: Foods
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, order
        case food = "Food"
    }
}

typealias FoodSections = [FoodSection]
