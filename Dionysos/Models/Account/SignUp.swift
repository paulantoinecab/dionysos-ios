//
//  SignUp.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 04/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct SignUp: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let password2: String
}
