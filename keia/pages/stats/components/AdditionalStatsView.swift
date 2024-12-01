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
                text: "Mean Instant Reward",
                help: "Describes the instant utility and quality of the products you want to buy"
            )
            
            SingleStatComponent(
                statistic: Text("\(service.getFutureValueFactor(), format: .number)"),
                text: "Mean Future Value Factor",
                help: "Describes the utility and quality in the future of the products you want to buy"
            )
            
            switch type {
            case .score:
                SingleStatComponent(
                    statistic: Text("\(service.getMeanScore(), format: .number)"),
                    text: "Mean Score",
                    help: "The mean score of your purchases/savings"
                )
            case .expense, .savings:
                SingleStatComponent(
                    statistic: Text("\(service.getMeanPrice(), format: .number)"),
                    text: "Mean Price",
                    help: type == .expense
                    ? "The mean price of your purchases"
                    : "The mean price of your savings"
                )
            }
            
            switch type {
            case .score:
                SingleStatComponent(
                    statistic: Text("\(service.getScoreTrend(), format: .percent)"),
                    text: "Score Trend",
                    help: "Describes the increase/decrease in score of your purchases/savings"
                )
            case .expense, .savings:
                SingleStatComponent(
                    statistic: Text("\(service.getInstantReward(), format: .percent)"),
                    text: type == .expense ? "Expense Trend" : "Save Trend",
                    help: type == .expense
                    ? "Describes the increase/decrease in price of your purchases"
                    : "Describes the increase/decrease in price of your savings"
                )
            }
            
            switch type {
            case .score:
                SingleStatComponent(
                    statistic: Text("\(service.getScoreSTD(), format: .number)"),
                    text: "Score Stability",
                    help: "Bigger the number, less stable are the scores of your purchases/savings"
                )
            case .expense, .savings:
                SingleStatComponent(
                    statistic: Text("\(service.getPriceSTD(), format: .number)"),
                    text: type == .expense ? "Expense Stability" : "Save Stability",
                    help: type == .expense
                    ? "Bigger the number, less stable are the prices of your purchases"
                    : "Bigger the number, less stable are the prices of your savings"
                )
            }
            
            if type == .expense {
                SingleStatComponent(
                    statistic: Text("\(service.getPercentageAboveThreshold(), format: .percent)"),
                    text: "Good Purchases",
                    help: "The percentage of purchases with a score greater than 6.0"
                )
                
                SingleStatComponent(
                    statistic: Text("\(service.getPercentageBelowThreshold(), format: .percent)"),
                    text: "Bad Purchases",
                    help: "The percentage of purchases with a score less than 6.0"
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
