import SwiftUI

struct BlogListView: View {
    let blogDatas = ["Markets insight":[BlogItems(title: "Trends That Will Define Next Quarter", file: "m1"),
                                  BlogItems(title: "How to Master Emerging Markets", file: "m2"),
                                  BlogItems(title: "Global Market Shifts Explained Simply", file: "m2")],
                     "Ethics and values":[BlogItems(title: "The Role of Integrity in Business", file: "e1"),
                               BlogItems(title: "Aligning Corporate Strategy with Ethics", file: "e2"),
                               BlogItems(title: "How Values Shape Leadership Today", file: "e3")],
                     "Development":[BlogItems(title: "Crafting Scalable Solutions for Growth", file: "d1"),
                            BlogItems(title: "Embracing Agile: Lessons in Progress", file: "d2"),
                            BlogItems(title: "Tools to Accelerate Your Team's Workflow", file: "d3")],
                     "Sustainbility":[BlogItems(title: "Building a Greener Future Together", file: "s1"),
                             BlogItems(title: "Top Innovations in Renewable Energy", file: "s2"),
                             BlogItems(title: "Practical Steps Toward Carbon Neutrality", file: "s3")]
                     ]
    
    @State private var searchTerm = ""
    
    var filteredBlog: [BlogItems]{
        if searchTerm.isEmpty{
            return blogDatas.values.flatMap{$0}
        } else {
            return blogDatas.values.flatMap{$0}.filter { blog in
                blog.title.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if searchTerm.isEmpty{
                    VStack(alignment: .leading, spacing: 20){
                        ForEach(blogDatas.keys.sorted(), id: \.self){ category in
                            VStack(alignment: .leading){
                                Text(category)
                                    .font(.title2)
                                    .bold()
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal){
                                    LazyHStack(spacing: 16){
                                        ForEach(blogDatas[category]!) { blog in
                                            NavigationLink(destination: BlogCardView(blogTitle: blog.title)){
                                                BlogCard(blog: blog)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 20){
                        ForEach(filteredBlog) { blog in
                            NavigationLink(destination: BlogCardView(blogTitle: blog.title)){
                                BlogCard(blog: blog)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Blog page")
        }
        .searchable(text: $searchTerm, prompt:"Search the name of the blog here")
    }
}

#Preview {
    BlogListView()
}
