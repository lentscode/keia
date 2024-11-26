//
//  PurchaseIntent.swift
//  keia
//
//  Created by Antonio Lentini on 21/11/24.
//

import Foundation
import SwiftData


@Model
/// Represents a wish of the user to buy something.
class PurchaseIntent: Identifiable {
    /// Unique id of the purchase.
    var id = UUID()
    /// Name of the product the user wants to buy
    var product: String
    /// Price of the ``product``.
    var price: Double
    /// Score assigned to the purchase.
    var score: Double
    /// Time when the purchase was created.
    var createdAt: Date
    /// Whether the user will buy the product or not.
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
