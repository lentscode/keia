//
//  HistoryView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct HistoryView: View {
    var objects: [PurchaseIntent]
    @State private var searchTerm = ""
    
    var body: some View {
            NavigationStack {
                ScrollView {
                    ForEach(objects, id: \.id) { object in
                        PurchaseIntentCard(purchase: object)
                        .padding(.bottom, 8)
                        .padding([.leading, .trailing], 16)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                        }, label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundColor(.black)
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("Prime"))
                        })
                    }
                }
                .navigationTitle("History")
            }
            .searchable(text: $searchTerm)
    }
}

#Preview {
    HistoryView(
        objects: [
            PurchaseIntent(product: "Mac Book Pro M4 Pro", price: 4200, score: 7.7, purchased: false),
            PurchaseIntent(product: "iPhone 16", price: 890, score: 8.9, purchased: false)
        ]
    )
}

