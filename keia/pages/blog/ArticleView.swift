import SwiftUI

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        Text("This blog is about  \(article.title)")
            .font(.largeTitle.bold())
            .padding()
    }
}

#Preview {
    ArticleView(
        article: Article(title: "Ciao", category: "Category", file: "Aidjiosad.md")
    )
}
