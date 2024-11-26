//
//  GeneralStatsView.swift
//  keia
//
//  Created by Francesco Romeo on 26/11/24.
//

import SwiftUI

struct GeneralStatsView: View {
    private let purchases: [PurchaseIntent]
    private let report: ChooseReport
    private let type: ChartType

    init(purchases: [PurchaseIntent], report: ChooseReport, type: ChartType) {
        self.purchases = purchases
        self.report = report
        self.type = type
    }

    var body: some View {
        VStack {
            Text(getMessage())
                .font(.headline)
                .foregroundColor(.gray)

            Text("\(getValue(), specifier: "%.2f")")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color("Prime"))
        }
    }
}

extension GeneralStatsView {
    func getMessage() -> String {
        switch type {
        case .savings:
            switch report {
            case .weekly:
                return "This week you saved"
            case .monthly:
                return "This month you saved"
            case .annual:
                return "This year you saved"
            }
        case .expense:
            switch report {
            case .weekly:
                return "Your total weekly expense is"
            case .monthly:
                return "Your total monthly expense is"
            case .annual:
                return "Your total annual expense is"
            }
        case .score:
            switch report {
            case .weekly:
                return "Your avarege weekly score is"
            case .monthly:
                return "Your avarege monthly score is"
            case .annual:
                return "Your avarege annual score is"
            }
        }
    }

    func getValue() -> Double {
        if type == .score {
            let totalScore = purchases.reduce(0, { $0 + $1.score })
            return totalScore / Double(purchases.count)
        }
        return purchases.reduce(0, { $0 + $1.price })
    }
}

#Preview {
    GeneralStatsView(
        purchases: [
            PurchaseIntent(
                product: "MacBook Pro", price: 2000, score: 9.5, purchased: true
            ),
            PurchaseIntent(
                product: "iPhone 15", price: 1200, score: 8.2, purchased: true),
            PurchaseIntent(
                product: "iPad Air", price: 800, score: 7.1, purchased: false),
        ],

        report: .weekly,
        type: .score

    )
}
