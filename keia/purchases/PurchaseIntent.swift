//
//  PurchaseIntent.swift
//  keia
//
//  Created by Antonio Lentini on 17/11/24.
//

import Foundation
import SwiftData

class PurchaseIntent {
    var name: String
    var amount: Double
    var purchased: Bool
    
    init(name: String, amount: Double, purchased: Bool) {
        self.name = name
        self.amount = amount
        self.purchased = purchased
    }
}
