//
//  ArticleFirstPageView.swift
//  keia
//
//  Created by Francesco Romeo on 29/11/24.
//

import SwiftUI

struct ArticleFirstPageView: View {

    let article: Article
    let readMore: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(article.image)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
                .overlay(Color.black.opacity(0.2))

            VStack(alignment: .leading, spacing: 12) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Button(action: readMore) {
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
        .frame(height: 300)
        .cornerRadius(30)
        .shadow(radius: 50)
        .padding(.horizontal)

    }
}

#Preview {
    ArticleFirstPageView(
        article: Article(
            title: "Economy insights",
            category: "Marketing",
            image: "m3",
            text: "about us",
            author: "Francesco Romeo",
            date: Date()),
        readMore: {
            print("Read More!")
        }
    )
}
