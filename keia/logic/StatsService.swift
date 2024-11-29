//
//  StatsService.swift
//  keia
//
//  Created by Antonio Lentini on 29/11/24.
//

import Foundation

class StatsService {
    static func getInstantValue(purchases: [PurchaseIntent]) {
        let counter = purchases.reduce(0.0, {$0 + $1})
        
    }
}
