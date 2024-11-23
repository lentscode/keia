//
//  BlogService.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import Foundation

class BlogService {
    private let articles = [
        Article(title: "Prova 1", category: "A", file: "d3"),
        Article(title: "Prova 2", category: "B", file: "d3"),
        Article(title: "Prova 3", category: "B", file: "d3"),
        Article(title: "Prova 4", category: "C", file: "d3"),
        Article(title: "Prova 5", category: "C", file: "d3"),
    ]
    
    func getArticlesByCategory(where filter: String? = nil) -> [String: [Article]] {
        var dict: [String: [Article]] = [:]
        
        var sortedArticles = articles
        
        if let filter {
            sortedArticles = sortedArticles.filter({$0.title.localizedStandardContains(filter)})
        }
        
        for article in sortedArticles {
            dict[article.category, default: []].append(article)
        }

        return dict
    }
}
