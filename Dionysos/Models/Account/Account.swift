//
//  Account.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 26/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct Account: Codable {
    let username, firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
