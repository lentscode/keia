//
//  StatsService.swift
//  keia
//
//  Created by Antonio Lentini on 29/11/24.
//

import Foundation

class StatsService {
    private let purchases: [PurchaseIntent]
    
    init(purchases: [PurchaseIntent]) {
        self.purchases = purchases
    }
    
    func getInstantReward() -> Double {
        guard length > 0 else { return 0.0}
        
        let counter = purchases.reduce(0.0, {$0 + $1.questions[0].points + $1.questions[2].points})
        return counter / Double(length)
    }
    
    func getPresentValueFactor() -> Double {
        guard length > 0 else { return 0.0}
        
        let counter = purchases.reduce(0.0, {$0 + $1.questions[1].points + $1.questions[3].points})
        return counter / Double(length)
    }
    
    func getFutureValueFactor() -> Double {
        guard length > 0 else { return 0.0}
        
        let counter = purchases.reduce(0.0, {$0 + $1.questions[4].points + $1.questions[5].points})
        return counter / Double(length)
    }
    
    func getMinimumPrice() -> Double {
        guard length > 0 else { return 0.0}
        
        return purchases.reduce(purchases[0].price, {$0 > $1.price ? $1.price : $0})
    }
    
    func getMaximumPrice() -> Double {
        guard length > 0 else { return 0.0}
        
        return purchases.reduce(purchases[0].price, {$0 < $1.price ? $1.price : $0})
    }
    
    func getMeanPrice() -> Double {
        guard length > 0 else { return 0.0}
        
        return purchases.reduce(0.0, {$0 + $1.price}) / Double(length)
    }
    
    func getMinimumScore() -> Double {
        guard length > 0 else { return 0.0}
        
        return purchases.reduce(purchases[0].score, {$0 > $1.score ? $1.score : $0})
    }
    
    func getMaximumScore() -> Double {
        guard length > 0 else { return 0.0}
        
        return purchases.reduce(purchases[0].score, {$0 < $1.score ? $1.score : $0})
    }
    
    func getMeanScore() -> Double {
        guard length > 0 else { return 0.0 }
        
        return purchases.reduce(0.0, {$0 + $1.score}) / Double(length)
    }
    
    func getPriceTrend() -> Double {
        guard length > 1 else { return 0.0 }
        
        return (purchases.last!.price -  purchases.first!.price) / purchases.first!.price
    }
    
    func getScoreTrend() -> Double {
        guard length > 1 else { return 0.0 }
        
        return (purchases.last!.score -  purchases.first!.score) / purchases.first!.score
    }
    
    func getPriceSTD() -> Double {
        guard length > 0 else { return 0.0 }
        
        let meanPrice = getMeanPrice()
        
        let variance = purchases.reduce(0.0, {$0 + pow($1.price - meanPrice, 2)}) / Double(length)
        
        return sqrt(variance)
    }
    
    func getScoreSTD() -> Double {
        guard length > 0 else { return 0.0 }
        
        let meanScore = getMeanScore()
        
        let variance = purchases.reduce(0.0, {$0 + pow($1.score - meanScore, 2)}) / Double(length)
        
        return sqrt(variance)
    }
    
    func getPercentageAboveThreshold() -> Double {
        guard length > 0 else { return 0.0 }
        
        let purchasesAboveThreshold = purchases.filter({$0.score >= 6.0})
        
        return Double(purchasesAboveThreshold.count) / Double(length)
    }
    
    func getPercentageBelowThreshold() -> Double {
        guard length > 0 else { return 0.0 }
        
        return 1 - getPercentageAboveThreshold()
    }
    
    private var length: Int {
        purchases.count
    }
}
