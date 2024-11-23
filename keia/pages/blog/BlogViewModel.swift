//
//  BlogViewModel.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import Foundation

class BlogViewModel: ObservableObject {
    private let blogService: BlogService
    
    @Published private(set) var articlesPerCategory: [String: [Article]]
    @Published var searchTerm = "" {
        didSet {
            if searchTerm.isEmpty {
                articlesPerCategory = blogService.getArticlesByCategory()
            } else {
                articlesPerCategory = blogService.getArticlesByCategory(where: searchTerm)
            }
        }
    }
    @Published var articleFocused: Article? {
        didSet {
            showSheet = articleFocused != nil
        }
    }
    @Published var showSheet = false
    
    init(blogService: BlogService) {
        self.blogService = blogService
        
        articlesPerCategory = self.blogService.getArticlesByCategory()
    }
}
