//
//  HistoryPurchaseList.swift
//  keia
//
//  Created by Antonio Lentini on 24/11/24.
//

import SwiftUI
import SwiftData

struct HistoryPurchaseList: View {
    @Query(
        sort: [
            SortDescriptor<PurchaseIntent>(\.createdAt, order: .reverse)
        ]
    ) private var purchases: [PurchaseIntent]
    @EnvironmentObject private var hvm: HistoryViewModel
    
    init(sorting: SortDescriptor<PurchaseIntent>, filter: String) {
        _purchases = Query(
            filter: #Predicate {filter.isEmpty ? true : $0.product.localizedStandardContains(filter)},
            sort: [sorting]
        )
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(purchases, id: \.id) { purchase in
                    PurchaseIntentCard(purchase: purchase)
                        .padding(.bottom, 8)
                        .padding([.leading, .trailing], 16)
                        .onTapGesture {
                            hvm.focusedPurchase = purchase
                        }
                }
            }
        }
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: [PurchaseIntent.self])
        .environmentObject(
            CreatePurchaseIntentViewModel(
                questions: [
                    Question(text:"Does this product solve an urgent need?", weight: 6, isSlider: false),
                    Question(text:"Has the best quality/price ratio?", weight: 4, isSlider: true)
                ]
            )
        )
        .environmentObject(HistoryViewModel())
}
