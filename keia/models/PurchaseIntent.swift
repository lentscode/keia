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
    
    var questions: [PurchaseQuestion]
    
    init(
        id: UUID = UUID(),
        product: String,
        price: Double,
        score: Double,
        purchased: Bool,
        questions: [PurchaseQuestion]
    ) {
        self.id = id
        self.product = product
        self.price = price
        self.score = score
        createdAt = Date()
        self.purchased = purchased
        self.questions = questions
    }
    
    init(
        id: UUID = UUID(),
        product: String,
        price: Double,
        score: Double,
        purchased: Bool,
        questions: [Question]
    ) {
        self.id = id
        self.product = product
        self.price = price
        self.score = score
        createdAt = Date()
        self.purchased = purchased
        self.questions = questions.map({PurchaseQuestion(from: $0)})
    }
}

@Model
class PurchaseQuestion: Identifiable {
    var id = UUID()
    var text: String
    var weight: Double
    var isSlider: Bool
    var reversed: Bool
    var points: Double
    
    init(id: UUID = UUID(), text: String, weight: Double, isSlider: Bool, reversed: Bool, points: Double) {
        self.id = id
        self.text = text
        self.weight = weight
        self.isSlider = isSlider
        self.reversed = reversed
        self.points = points
    }
    
    init(from question: Question) {
        text = question.text
        weight = question.weight
        isSlider = question.isSlider
        reversed = question.reversed
        points = question.points ?? 0
    }
}
