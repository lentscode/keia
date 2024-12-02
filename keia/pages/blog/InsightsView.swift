//
//  InsightsView.swift
//  keia
//
//  Created by Francesco Romeo on 29/11/24.
//

import SwiftUI

struct InsightsView: View {
    @EnvironmentObject private var vm: InsightsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let article = vm.articleInEvidence {
                    ArticleInEvidenceView(
                        article: article
                    )
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                    .padding(.horizontal)
                }
                
                InsightsTabBar()
                    .padding(.horizontal)
                
                ArticlesListView()
                    .padding(.horizontal)
            }
            
            .navigationTitle("Insights")
            .searchable(text: $vm.searchTerm, prompt: "Search")
        }
    }
}

#Preview {
    InsightsView()
        .environmentObject(
            InsightsViewModel(
                insightsService: InsightsService()
            )
        )
}
