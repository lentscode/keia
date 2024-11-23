import SwiftUI

struct BlogCard: View {
    
    let blog: BlogItems
    
    var body: some View {
        HStack {
            //Image blog
            Image(blog.file)
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            //Title blog
            Text(blog.title)
                .font(.system(size: 17, weight: .regular, design: .default))
                .foregroundColor(.black)
                .padding(.leading, 10)
                .lineLimit(nil)
            
             // Spinge il contenuto a sinistra
        }
        .padding()
        .frame(width: 365, height: 120)
        .background(Color.gray.opacity(0.07))
        .cornerRadius(40)
        .shadow(radius: 5)
    }
}

#Preview {
    BlogCard(blog: BlogItems(title: "Titolo di esempio", file: "blog_image"))
}

