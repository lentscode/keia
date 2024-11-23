//
//  MainTab.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct MainTab: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(0)
            HistoryView(objects: [PurchaseIntent(product: "Mac Book Pro M4 Pro", price: 4200, score: 7.7, purchased: false), PurchaseIntent(product: "iPhone 16", price: 890, score: 8.9, purchased: false)])
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(1)
            BlogView()
                .tabItem {
                    Label("Blog", systemImage: "newspaper")
                }
                .tag(2)
        }.tint(Color("Prime"))
    }
}

#Preview {
    MainTab()
}
