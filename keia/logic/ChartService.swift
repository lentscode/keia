//
//  ChartService.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import Foundation
import SwiftData

class ChartService {
    private let context: ModelContext
    
    private var now: Date {
        Date()
    }
    
    private var oneWeekAgo: Date {
        if let date = Calendar.current.date(byAdding: .day, value: -7, to: now) {
            return date
        }
        return Date()
    }
    
    private var oneMonthAgo: Date {
        if let date = Calendar.current.date(byAdding: .month, value: -1, to: now) {
            return date
        }
        return Date()
    }
    
    private var oneYearAgo: Date {
        if let date = Calendar.current.date(byAdding: .year, value: -1, to: now) {
            return date
        }
        return Date()
    }
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getPurchases(for type: StatsPeriod) -> [PurchaseIntent] {
        let period = switch type {
        case .month:
            oneMonthAgo
        case .week:
            oneWeekAgo
        case .year:
            oneYearAgo
        }
        
        let descriptor = FetchDescriptor<PurchaseIntent>(
            predicate: #Predicate {$0.createdAt >= period}
        )
        
        do {
            let purchases = try context.fetch(descriptor)
            return purchases
        } catch {
            return []
        }
    }
}

enum StatsPeriod {
    case week, month, year
}
