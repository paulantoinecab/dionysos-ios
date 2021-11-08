//
//  Food.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import UIKit

struct Food: Codable {
    let id: UUID
    let name: String
    let price: Double
    let ingredients: String
    let foodDescription: String
    var quantity: Int = 0
    let image: String
    let imageHash: String?
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, order
        case foodDescription = "description"
        case ingredients, image, imageHash
    }

}

typealias Foods = [Food]
