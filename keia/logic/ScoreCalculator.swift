//
//  ScoreCalculator.swift
//  keia
//
//  Created by Antonio Lentini on 21/11/24.
//

import Foundation

/// Service that calculates the score of a ``PurchaseIntent``.
/// - Parameters:
///     - purchase: the ``PurchaseIntent`` to calculate the score of.
///     - formData: the struct that contains all the ``Question``s.
struct ScoreCalculator {
    private var purchase: PurchaseIntent
    private var formData: PurchaseFormData
    
    init(purchase: PurchaseIntent, formData: PurchaseFormData) {
        self.purchase = purchase
        self.formData = formData
    }
    
    private func calculate() -> Double {
        var score = 0.0
        
        for question in formData.questions {
            if let points = question.points {
                score += points * question.weight
            }
        }
        
        return score
    }
    
    /// Calculates the score of the puchase and sets it to the `score` property
    /// of the ``PurchaseIntent``.
    func calculateScoreOfPurchase() {
        purchase.score = calculate()
    }
}
