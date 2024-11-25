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
    @Query private var purchases:[PurchaseIntent]
    private let report:ChooseReport
    private let type: ChartType
    private let color: Color
    
    init(type: ChartType, report: ChooseReport ,color: Color = .blue) {
        //_purchases = Query(filter: #Predicate{$0.createdAt})
        self.type = type
        self.color = color
        self.report = report
    }
    
    var body: some View {
        Chart(purchases) {
            LineMark(
                x: .value("Time", $0.createdAt),
                y: .value("Score", getDataForPurchase(purchase: $0, for: type))
            )
            
            PointMark(
                x: .value("Time", $0.createdAt),
                y: .value("Score", getDataForPurchase(purchase: $0, for: type))
            )
        }
        .foregroundStyle(color)
    }
}

extension PurchaseIntentsCharts {
    func getDataForPurchase(purchase: PurchaseIntent, for type: ChartType) -> Double {
        return switch type {
        case .expense, .savings:
            purchase.price
        case .score:
            purchase.score
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
        purchases: [
            PurchaseIntent(product: "", price: 23, score: 9.5, purchased: true),
            PurchaseIntent(product: "", price: 45, score: 2.5, purchased: true),
            PurchaseIntent(product: "", price: 12, score: 8.5, purchased: true),
            PurchaseIntent(product: "", price: 78, score: 9.5, purchased: true)
        ],
        type: .expense,
        color: .red
    )
    .frame(height: 200)
    .padding(.horizontal, 16)
}
