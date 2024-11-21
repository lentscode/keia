//
//  PurchaseIntent.swift
//  keia
//
//  Created by Antonio Lentini on 21/11/24.
//

import Foundation

class PurchaseIntent: Identifiable {
    var id = UUID()
    var product: String
    var price: Double
    var score: Double
    var createdAt: Date
    var purchased: Bool
    
    init(id: UUID = UUID(), product: String, price: Double, score: Double, purchased: Bool) {
        self.id = id
        self.product = product
        self.price = price
        self.score = score
        createdAt = Date()
        self.purchased = purchased
    }
}
