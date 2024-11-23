import SwiftUI

struct BlogCardView: View {
    
    let blogTitle:String
    
    var body: some View {
        Text("This blog is about  \(blogTitle)")
            .font(.largeTitle.bold())
            .padding()
    }
}

#Preview {
    BlogCardView(blogTitle: "blogtitle")
}
