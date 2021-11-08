//
//  ServerMessage.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 04/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct ServerMessage: Codable {
    let message: String
    let error: String?
}
