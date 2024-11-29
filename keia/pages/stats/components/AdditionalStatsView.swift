//
//  AdditionalStatsView.swift
//  keia
//
//  Created by Antonio Lentini on 29/11/24.
//

import SwiftUI
import TipKit

struct AdditionalStatsView: View {
    private let purchases: [PurchaseIntent]
    private let type: ChartType
    
    private let service: StatsService
    
    init(purchases: [PurchaseIntent], type: ChartType) {
        self.purchases = purchases
        self.type = type
        
        service = StatsService(purchases: purchases)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            SingleStatComponent(
                statistic: Text("\(service.getInstantReward(), format: .number)"),
                text: "Instant Reward"
            )
            
            SingleStatComponent(
                statistic: Text("\(service.getFutureValueFactor(), format: .number)"),
                text: "Future Value Factor"
            )
            
            switch type {
            case .score:
                SingleStatComponent(
                    statistic: Text("\(service.getMeanScore(), format: .number)"),
                    text: "Mean Score"
                )
            case .expense, .savings:
                SingleStatComponent(
                    statistic: Text("\(service.getMeanPrice(), format: .number)"),
                    text: "Mean Price"
                )
            }
            
            switch type {
            case .score:
                SingleStatComponent(
                    statistic: Text("\(service.getScoreTrend(), format: .percent)"),
                    text: "Score Trend"
                )
            case .expense, .savings:
                SingleStatComponent(
                    statistic: Text("\(service.getInstantReward(), format: .percent)"),
                    text: type == .expense ? "Expense Trend" : "Save Trend"
                )
            }
            
            switch type {
            case .score:
                SingleStatComponent(
                    statistic: Text("\(service.getScoreSTD(), format: .number)"),
                    text: "Score Stability"
                )
            case .expense, .savings:
                SingleStatComponent(
                    statistic: Text("\(service.getPriceSTD(), format: .number)"),
                    text: type == .expense ? "Expense Stability" : "Save Stability"
                )
            }
            
            if type == .expense {
                SingleStatComponent(
                    statistic: Text("\(service.getPercentageAboveThreshold(), format: .percent)"),
                    text: "Good Purchases"
                )
                
                SingleStatComponent(
                    statistic: Text("\(service.getPercentageBelowThreshold(), format: .percent)"),
                    text: "Bad Purchases"
                )
            }
        }
    }
}

fileprivate struct SingleStatComponent: View {
    private let statistic: Text
    private let text: String
    private let help: String?
    
    init(
        statistic: Text,
        text: String,
        help: String? = nil
    ) {
        self.statistic = statistic
        self.text = text
        self.help = help
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                
                if let help {
                    Text(help)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()
            
            statistic
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)
        }
    }
}
#Preview {
    AdditionalStatsView(
        purchases: [], type: .expense
    )
    .padding(.horizontal)
}
