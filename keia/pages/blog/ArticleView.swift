import SwiftUI
import MarkdownUI

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 16))
                    .padding(.bottom, 32)
                
                Text(article.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                
                HStack(alignment: .bottom) {
                    Text("by")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 2)
                    Text(article.author)
                    
                    
                    Spacer()
                    
                    Text(article.date.formatted())
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .padding(.leading)
                }
                
                Divider()
                    .padding(.bottom, 16)
                
                
                Markdown(article.text)
            }
            .padding()
        }
    }
}

#Preview {
    ArticleView(
        article: Article(
            title: "Il cielo è sempre più blu",
            category: "Category",
            image: "s3",
            text: """
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
                    
                    Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
                  
                  ## Sottotitolo
                  
                  It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                  """,
            author: "Antonio Lentini",
            date: Date()
        )
    )
}
