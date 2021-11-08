//
//  UIApplicationExtension.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 30/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
