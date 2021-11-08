//
//  ValidationBrokenRule.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 03/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation

struct ValidationBrokenRule {
    let message: String?
    let color: ValidationBrokenRuleColors
    
    init(message: String? = nil, color: ValidationBrokenRuleColors = .none) {
        self.message = message
        self.color = color
    }
}

enum ValidationBrokenRuleColors {
    case Red
    case Green
    case none
}
