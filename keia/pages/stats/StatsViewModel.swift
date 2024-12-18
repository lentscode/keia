//
//  StatsViewModel.swift
//  keia
//
//  Created by Francesco Romeo on 25/11/24.
//

import Foundation
import SwiftData

enum ChooseReport: String, CaseIterable{
    case weekly = "Weekly"
    case monthly = "Monthly"
    case annual = "Annual"
}

class StatsViewModel: ObservableObject {
    @Published var report: ChooseReport = .weekly
    @Published var type: ChartType = .savings
}

extension StatsViewModel {
    private var now: Date { Date.now }
    private var aWeekAgo: Date { Calendar.current.date(byAdding: .day, value: -7, to: now) ?? now}
    private var aMonthAgo: Date { Calendar.current.date(byAdding: .month, value: -1, to: now) ?? now}
    private var aYearAgo: Date { Calendar.current.date(byAdding: .year, value: -1, to: now) ?? now}
    
    func predicate() -> Predicate<PurchaseIntent> {
        switch type {
        case .expense:
            switch report {
            case .weekly:
                return #Predicate {$0.purchased && $0.createdAt >= aWeekAgo}
            case .monthly:
                return #Predicate {$0.purchased && $0.createdAt >= aMonthAgo}
            case .annual:
                return #Predicate {$0.purchased && $0.createdAt >= aYearAgo}
            }
        case .savings:
            switch report {
            case .weekly:
                return #Predicate {!$0.purchased && $0.createdAt >= aWeekAgo}
            case .monthly:
                return #Predicate {!$0.purchased && $0.createdAt >= aMonthAgo}
            case .annual:
                return #Predicate {!$0.purchased && $0.createdAt >= aYearAgo}
            }
        case .score:
            switch report {
            case .weekly:
                return #Predicate {$0.createdAt >= aWeekAgo}
            case .monthly:
                return #Predicate {$0.createdAt >= aMonthAgo}
            case .annual:
                return #Predicate {$0.createdAt >= aYearAgo}
            }
        }
    }
}
