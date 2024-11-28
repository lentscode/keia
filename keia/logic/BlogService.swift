//
//  BlogService.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import Foundation
import Yams
import SwiftUI

class BlogService {
    private var articles = [
        Article(title: "Prova 1", category: "A", file: "d3", text: "", author: ""),
        Article(title: "Prova 2", category: "B", file: "d3", text: "", author: ""),
        Article(title: "Prova 3", category: "B", file: "d3", text: "", author: ""),
        Article(title: "Prova 4", category: "C", file: "d3", text: "", author: ""),
        Article(title: "Prova 5", category: "C", file: "d3", text: "", author: ""),
    ]
    
    init() {
        loadArticles()
    }
    
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
    
    private func loadArticles() {
        let fm = FileManager()

        if let path = Bundle.main.resourcePath {
            do {
                let articlePaths = try fm.contentsOfDirectory(atPath: path)
                
                var articles: [Article] = []
                
                for articlePath in articlePaths {
                    guard articlePath.hasSuffix(".md") else { continue }
                    
                    let fullPath = (path as NSString).appendingPathComponent(articlePath)
                    
                    let metadata = getMetadata(filePath: fullPath)

                    let content = getContent(filePath: fullPath)
                    
                    if let metadata {
                        articles.append(
                            Article(
                                title: metadata.title,
                                category: metadata.category,
                                file: metadata.image,
                                text: content,
                                author: metadata.author
                            )
                        )
                    }
                }
                
                if !articles.isEmpty {
                    self.articles = articles
                }
            } catch {
                debugPrint("Errore durante il caricamento dei file: \(error)")
            }
        }
    }

    
    private func getMetadata(filePath: String) -> MarkdownMetadata? {
        do {
            let content = try String(contentsOfFile: filePath, encoding: .utf8)
            
            if let frontMatterRange = content.range(of: "---\n", options: [.regularExpression]) {
                let frontMatter = content[frontMatterRange.upperBound...].components(separatedBy: "---").first ?? ""
                if let yamlData = frontMatter.data(using: .utf8) {
                    let decoder = YAMLDecoder()
                    let metadata = try decoder.decode(MarkdownMetadata.self, from: yamlData)
                    debugPrint(metadata)
                    return metadata
                }
            }
        } catch {
            return nil
        }
        return nil
    }
    
    private func getContent(filePath: String) -> String {
        var content = ""
        do {
            let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
            
            guard let frontMatterStart = fileContent.range(of: "---\n") else {
                content = fileContent
                return content
            }
            
            guard let frontMatterEnd = fileContent.range(of: "---", options: [], range: frontMatterStart.upperBound..<fileContent.endIndex) else {
                content = fileContent
                return content
            }
            
            content = String(fileContent[frontMatterEnd.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            print("Errore durante il caricamento del contenuto: \(error)")
        }
        
        return content
    }
}

fileprivate struct MarkdownMetadata: Decodable {
    let title: String
    let author: String
    let category: String
    let image: String
}
