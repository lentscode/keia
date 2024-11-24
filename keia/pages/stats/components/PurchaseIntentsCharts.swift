//
//  PurchaseIntentsCharts.swift
//  keia
//
//  Created by Antonio Lentini on 24/11/24.
//

import SwiftUI
import Charts

struct PurchaseIntentsCharts: View {
    private let purchases: [PurchaseIntent]
    private let type: ChartType
    private let color: Color
    
    init(purchases: [PurchaseIntent], type: ChartType, color: Color = .blue) {
        self.purchases = purchases
        self.type = type
        self.color = color
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
        case .price:
            purchase.price
        case .score:
            purchase.score
        }
    }
}

enum ChartType {
    case score, price
}

#Preview {
    PurchaseIntentsCharts(
        purchases: [
            PurchaseIntent(product: "", price: 23, score: 9.5, purchased: true),
            PurchaseIntent(product: "", price: 45, score: 2.5, purchased: true),
            PurchaseIntent(product: "", price: 12, score: 8.5, purchased: true),
            PurchaseIntent(product: "", price: 78, score: 9.5, purchased: true)
        ],
        type: .price,
        color: .red
    )
    .frame(height: 200)
    .padding(.horizontal, 16)
}
