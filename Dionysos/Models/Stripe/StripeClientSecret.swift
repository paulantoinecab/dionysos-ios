//
//  StripeClientSecret.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 05/10/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct StripeClientSecret: Decodable {
    let clientSecret: String
    
    enum CodingKeys: String, CodingKey {
        case clientSecret = "client_secret"
    }
}
