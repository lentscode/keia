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
        }.tint(Color("Prime"))
    }
}

#Preview {
    MainTab()
}
