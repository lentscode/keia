//
//  InsightsViewModel.swift
//  keia
//
//  Created by Francesco Romeo on 29/11/24.
//

import Foundation

class InsightsViewModel: ObservableObject{
    private let insightsService: InsightsService
    
    @Published private(set) var articleInEvidence: Article?
    @Published var searchTerm = "" {
        didSet {
            if !searchTerm.isEmpty {
                articles = insightsService.articles.filter({$0.title.localizedStandardContains(searchTerm)})
            } else {
                articles = insightsService.articles
            }
        }
    }
    @Published private(set) var articles: [Article]
    @Published var categoryFocused: String? {
        didSet {
            if let categoryFocused {
                articles = insightsService.articles.filter({$0.category == categoryFocused})
            } else {
                articles = insightsService.articles
            }
        }
    }
    
    var categories: [String] {
        insightsService.categories
    }
    
    init(insightsService: InsightsService) {
        self.insightsService = insightsService
        
        articles = insightsService.articles
        
        articles.sort(by: {$0.date > $1.date})
        
        if let article = articles.first {
            articleInEvidence = article
        }
    }
}
