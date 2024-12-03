//
//  ArticlesFundamentalsView.swift
//  keia
//
//  Created by Miriam Listì on 28/11/24.
//

import SwiftUI

struct ArticlesListView: View {
    @EnvironmentObject private var vm: InsightsViewModel
    
    var body: some View {
        ForEach(0..<vm.articles.count, id: \.self) { index in
            NavigationLink {
                ArticleView(article: vm.articles[index])
            } label: {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(vm.articles[index].title)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .padding(.bottom, 4)
                            Text(getDate(article: vm.articles[index]))
                                .font(.footnote)
                                .foregroundStyle( .gray)
                        }
                        Spacer()
                        
                        Image(vm.articles[index].image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 90)
                            .cornerRadius(15)              
                            .clipped()
                    }
                    
                    if index < vm.articles.count - 1 {
                        Divider()
                            .padding(.vertical, 4)
                    }
                }
            }
        }
    }
}

extension ArticlesListView{
    func getDate(article: Article) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMdy")
        
        return formatter.string(from: article.date)
    }
}

#Preview {
    ArticlesListView()
        .padding(.horizontal)
        .environmentObject(InsightsViewModel(insightsService: InsightsService()))
}
