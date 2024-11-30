//
//  ArticleFirstPageView.swift
//  keia
//
//  Created by Francesco Romeo on 29/11/24.
//

import SwiftUI

struct ArticleInEvidenceView: View {
    
    let article: Article
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(article.image)
                .resizable()
                .scaledToFill()
                .frame(height: 350)
                .clipped()
                .overlay(Color.black.opacity(0.2))
            
            VStack(alignment: .leading, spacing: 12) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                NavigationLink {
                    ArticleView(article: article)
                } label: {
                    HStack {
                        Text("Read more")
                            .font(.subheadline)
                        
                        Image(systemName: "arrow.right")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.9))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .frame(height: 350)
        .cornerRadius(30)
        .shadow(radius: 16)
        .padding(.horizontal)
        
    }
}

#Preview {
    ArticleInEvidenceView(
        article: Article(
            title: "Economy insights",
            category: "Marketing",
            image: "m3",
            text: "about us",
            author: "Francesco Romeo",
            date: Date()
        )
    )
}
