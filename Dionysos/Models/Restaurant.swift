//
//  Restaurant.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import UIKit
struct Restaurant: Codable {
    let id: UUID
    let name, profilePic: String
    let profilePicHash: String?
    let sections: [Section]

    enum CodingKeys: String, CodingKey {
        case id, name, profilePic, profilePicHash
        case sections = "Sections"
    }
}
