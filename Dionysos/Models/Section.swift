//
//  Section.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import UIKit

struct Section: Codable {
    let id: UUID
    let name: String
    let categories: [Category]
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id, name, order
        case categories = "Category"
    }
}
typealias Sections = [Section]
