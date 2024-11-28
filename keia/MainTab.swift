//
//  MainTab.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct MainTab: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(0)
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(1)
            BlogView( )
                .tabItem {
                    Label("Blog", systemImage: "newspaper")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainTab()
        .environmentObject(
            CreatePurchaseIntentViewModel(
                questions: [
                    Question(text:"Does this product solve an urgent need?", weight: 6, isSlider: false),
                    Question(text:"Has the best quality/price ratio?", weight: 4, isSlider: true)
                ]
            )
        )
        .environmentObject(HistoryViewModel())
}
