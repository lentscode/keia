//
//  HistoryView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct HistoryView: View {
    
    var objects: [PurchaseIntent]
    var body: some View {
            List{
                ForEach(objects, id: \.id){ object in
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack{
                            Text(object.product)
                                .bold()
                            Spacer()
                            Text("\(object.score, specifier: "%.2f")/10")
                        }
                        Spacer()
                        Text("\(object.price, specifier: "%.2f")€")
                        Spacer()
                    }
                }
            }
        
    }

}

#Preview {
    HistoryView(objects: [PurchaseIntent(product: "Mac Book Pro M4 Pro", price: 4200, score: 7.7, purchased: false), PurchaseIntent(product: "iPhone 16", price: 890, score: 8.9, purchased: false)])
}
