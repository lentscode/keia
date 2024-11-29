//
//  TabBar.swift
//  keia
//
//  Created by Francesco Romeo on 28/11/24.
//

import SwiftUI

struct TabBar: View {

    let categories: [String]
    @State private var defaultTab: String
    
    init(categories: [String]) {
        self.categories = categories
        self.defaultTab = categories.first ?? "All"
    }

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.self) { cat in
                    VStack {
                        Text(cat)
                            .font(.system(size: 20))
                            .fontWeight(defaultTab == cat ? .bold : .regular)
                            .foregroundColor(defaultTab == cat ? .black : .gray)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 5)

                        // Linea di sottolineatura
                        Rectangle()
                            .fill(defaultTab == cat ? Color.black : Color.clear)
                            .frame(height: 2)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            defaultTab = cat
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TabBar(categories: ["All", "Tech", "Marketing", "IA","Daily News","Personal finances"])
}
