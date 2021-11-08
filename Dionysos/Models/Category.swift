//
//  Categories.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import UIKit

struct Category: Codable {
    let id: UUID
    let name, image: String
    let imageHash: String?
    let headers: [Food]
    let foodSections: FoodSections
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id, name, image, imageHash, order
        case headers = "Headers"
        case foodSections = "FoodSections"
    }
}

typealias Categories = [Category]
