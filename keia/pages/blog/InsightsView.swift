//
//  InsightsView.swift
//  keia
//
//  Created by Francesco Romeo on 29/11/24.
//

import SwiftUI

struct InsightsView: View {
    
    let sampleArticle = Article(
        title: "Economy insights",
        category: "Marketing",
        image: "m3",
        text: "Exploring the latest trends in marketing.",
        author: "Francesco Romeo",
        date: Date()
    )
    
    @State private var searchTerm = ""
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ArticleFirstPageView(
                    article: sampleArticle,
                    readMore: {
                        print("Read More!")
                    })
                
                TabBar(categories: ["All", "Tech", "Marketing", "IA","Daily News","Personal finances"])
                Spacer()
            }
            .navigationTitle("Insights")
            .searchable(text: $searchTerm, prompt: "Search")
            
        }
    }
}

#Preview {
    InsightsView()
}
