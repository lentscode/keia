//
//  ViewExtensions.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import SwiftUI

extension View {
    /// Enables the ``CreationProcessView`` sheet for a page of the ``MainTab``
    func purchaseSheet(
        isCreationProcessPresented: Binding<Bool>,
        isPurchaseScorePresented: Binding<Bool>,
        purchase: PurchaseIntent?,
        dismissAction: (() -> Void)? = nil
    ) -> some View {
        sheet(
            isPresented: isCreationProcessPresented,
            onDismiss: {
                if !isPurchaseScorePresented.wrappedValue {
                    dismissAction?()
                }
            }
        ) {
            CreationProcessView()
        }
        .sheet(isPresented: isPurchaseScorePresented) {
            if let purchase {
                PurchaseScoreView(purchase: purchase)
            }
        }
    }
    
    func setEnvironment() -> some View {
        environmentObject(StatsViewModel())
            .environmentObject(
                CreatePurchaseIntentViewModel(
                    questions: [
                        Question(text: "How much this product solve an urgent need?", weight: 2, isSlider: true),
                        Question(text: "Does it last long and is it reusable?", weight: 2, isSlider: false),
                        Question(text: "How long did you think about this purchase?", weight: 1.5, isSlider: true),
                        Question(text: "Does it have the best quality/price ratio?", weight: 1.5, isSlider: false),
                        Question(text: "How much this product impacts on your budget?", weight: 2, isSlider: true, reversed: true),
                        Question(text: "Can it lead to future earnings?", weight: 1, isSlider: false)
                    ]
                )
            )
            .environmentObject(HistoryViewModel())
            .environmentObject(InsightsViewModel(insightsService: InsightsService()))
    }
}
