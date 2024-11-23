import SwiftUI

struct BlogView: View {
    @EnvironmentObject private var vm: BlogViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(
                        vm.articlesPerCategory.sorted(by: {$0.key < $1.key}),
                        id: \.key
                    ) { category, articles in
                        VStack(alignment: .leading) {
                            Text(category)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            categoryArticlesList(articles: articles)
                        }
                        .padding(.bottom, 8)
                    }
                }
            }
            .padding(.top, 16)
            .navigationTitle("Blog")
        }
        .searchable(text: $vm.searchTerm, prompt: "Search for article...")
        .sheet(isPresented: $vm.showSheet, onDismiss: {
            vm.articleFocused = nil
        }) {
            if let article = vm.articleFocused {
                ArticleView(article: article)
            }
        }
    }
    
    @ViewBuilder func categoryArticlesList(articles: [Article]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(articles.indices, id: \.self) { index in
                    ArticleCard(article: articles[index])
                        .padding(.leading, index == 0 ? 16 : 0)
                        .padding(.trailing, index == articles.count - 1 ? 16 : 0)
                        .onTapGesture {
                            vm.articleFocused = articles[index]
                        }
                }
            }
        }
        .scrollIndicators(.never)
    }
    
}

#Preview {
    BlogView()
        .environmentObject(BlogViewModel(blogService: BlogService()))
}
