//
//  StripeContext.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 04/10/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Stripe

struct StripeContext {
    static let sharedCustomerContext = STPCustomerContext(keyProvider: StripeAPIClient.shared)
}
