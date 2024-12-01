//
//  MainApp.swift
//  keia
//
//  Created by Antonio Lentini on 12/11/24.
//

import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            MainTab()
                .modelContainer(for: [PurchaseIntent.self])
                .environmentObject(
                    CreatePurchaseIntentViewModel(
                        questions: [
                            //TODO: Add all questions
                            Question(text: "Does this product solve an urgent need?", weight: 6, isSlider: false),
                            Question(text: "Has the best quality/price ratio?", weight: 4, isSlider: true)
                        ]
                    )
                )
                .environmentObject(HistoryViewModel())
                .environmentObject(InsightsViewModel(insightsService: InsightsService()))
        }
    }
}
