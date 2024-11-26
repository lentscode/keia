//
//  PurchaseIntentsCharts.swift
//  keia
//
//  Created by Antonio Lentini on 24/11/24.
//

import SwiftUI
import Charts
import SwiftData

struct PurchaseIntentsCharts: View {
    @Query private var purchases: [PurchaseIntent]
    private let report: ChooseReport
    private let type: ChartType
    private let color: Color
    
    init(type: ChartType, report: ChooseReport) {
        self.type = type
        self.report = report
        
        color = switch type {
        case .expense:
                .red
        case .savings:
                .green
        case .score:
                .blue
        }
        
        _purchases = Query(
            filter: getPredicate(type: type, report: report),
            sort: \.createdAt
        )
    }
    
    var body: some View {
        Chart(purchases) {
            LineMark(
                x: .value("Time", $0.createdAt),
                y: .value(type.rawValue, getDataForPurchase(purchase: $0, for: type))
            )
            
            PointMark(
                x: .value("Time", $0.createdAt),
                y: .value(type.rawValue, getDataForPurchase(purchase: $0, for: type))
            )
        }
        .foregroundStyle(color)
    }
}

extension PurchaseIntentsCharts {
    private var now: Date { Date.now }
    private var aWeekAgo: Date { Calendar.current.date(bySetting: .day, value: -7, of: now) ?? now}
    private var aMonthAgo: Date { Calendar.current.date(bySetting: .month, value: -1, of: now) ?? now}
    private var aYearAgo: Date { Calendar.current.date(bySetting: .year, value: -1, of: now) ?? now}
    
    func getDataForPurchase(purchase: PurchaseIntent, for type: ChartType) -> Double {
        return switch type {
        case .expense, .savings:
            purchase.price
        case .score:
            purchase.score
        }
    }
    
    func getPredicate(type: ChartType, report: ChooseReport) -> Predicate<PurchaseIntent> {
        switch type {
        case .expense:
            switch report {
            case .weekly:
                return #Predicate {$0.purchased && $0.createdAt < aWeekAgo}
            case .monthly:
                return #Predicate {$0.purchased && $0.createdAt < aMonthAgo}
            case .annual:
                return #Predicate {$0.purchased && $0.createdAt < aYearAgo}
            }
        case .savings:
            switch report {
            case .weekly:
                return #Predicate {!$0.purchased && $0.createdAt < aWeekAgo}
            case .monthly:
                return #Predicate {!$0.purchased && $0.createdAt < aMonthAgo}
            case .annual:
                return #Predicate {!$0.purchased && $0.createdAt < aYearAgo}
            }
        case .score:
            switch report {
            case .weekly:
                return #Predicate {$0.createdAt < aWeekAgo}
            case .monthly:
                return #Predicate {$0.createdAt < aMonthAgo}
            case .annual:
                return #Predicate {$0.createdAt < aYearAgo}
            }
        }
    }
}

enum ChartType: String, CaseIterable {
    case score = "Score"
    case expense = "Expenses"
    case savings = "Savings"
}

#Preview {
    PurchaseIntentsCharts(
        type: .expense,
        report: .weekly
    )
    .frame(height: 200)
    .padding(.horizontal, 16)
}
