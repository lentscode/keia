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
    private var purchases: [PurchaseIntent]
    private let report: ChooseReport
    private let type: ChartType
    private let color: Color
    
    init(purchases: [PurchaseIntent], type: ChartType, report: ChooseReport) {
        self.purchases = purchases
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
    }
    
    var body: some View {
        if purchases.isEmpty {
            Text("No data")
        } else {
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
        purchases: [],
        type: .expense,
        report: .weekly
    )
    .frame(height: 200)
    .padding(.horizontal, 16)
}
