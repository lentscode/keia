import SwiftUI
import MarkdownUI

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        Markdown(article.text)
            .padding()
    }
}

#Preview {
    ArticleView(
        article: Article(
            title: "Ciao",
            category: "Category",
            file: "",
            text: "",
            author: ""
        )
    )
}
