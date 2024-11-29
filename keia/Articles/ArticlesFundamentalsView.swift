//
//  ArticlesFundamentalsView.swift
//  keia
//
//  Created by Miriam Listì on 28/11/24.
//

import SwiftUI

struct ArticlesFundamentalsView: View {
    
    let articles : [Article]
    
    var body: some View {
        ScrollView{
            GroupBox{
                ForEach(articles, id:\.id) { article in
                    HStack{
                        VStack(){
                            Text(article.title)
                                .bold()
                                .font(.system(size: 20))
                                .padding()
                            Text(getDate(article: article))
                                .foregroundStyle( .gray)
                        }
                        Spacer()
                        Image(article.image)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 125, height: 90)
                    }
                    Divider()
                }
            }
        }
        .groupBoxStyle(.item)
    }
}

#Preview {
    ArticlesFundamentalsView(articles:[
                            Article(title: "Articolo di prova",
                                    category: "Prova",
                                    image: "s2",
                                    text: "",
                                    author: "Autore",
                                    date: Date()),
                            Article(title: "Articolo di prova2",
                                    category: "Prova",
                                    image: "m2",
                                    text: "",
                                    author: "Autore",
                                    date: Date())])
}


fileprivate struct ObjectsGroupBoxStyle : GroupBoxStyle {
    var backgroundColor: UIColor = UIColor.white
    var labelColor: UIColor = UIColor.label
    var opacity: Double = 1
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            configuration.label
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color(labelColor))
            
            configuration.content
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(backgroundColor))
        )
        .opacity(opacity)
    }
}

extension GroupBoxStyle where Self == ObjectsGroupBoxStyle{
    static var item: ObjectsGroupBoxStyle{ .init() }
}

extension ArticlesFundamentalsView{
    func getDate(article: Article) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMdy")
        
        return formatter.string(from: article.date)
    }
}
