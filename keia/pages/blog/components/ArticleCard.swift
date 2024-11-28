import SwiftUI

struct ArticleCard: View {
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        HStack {
            //Image blog
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .foregroundColor(.white)
            
            //Title blog
            Text(article.title)
                .font(.title2)
                .foregroundColor(.black)
                .padding(.leading, 10)
                .lineLimit(nil)
            
            Spacer()
            
             // Spinge il contenuto a sinistra
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .frame(width: 365, height: 120)
        .background(Color.gray.opacity(0.07))
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

#Preview {
    ArticleCard(article: Article(title: "Titolo di esempio", category: "Category", image: "d3", text: "", author: "", date: Date()))
}

