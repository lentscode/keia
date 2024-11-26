//
//  HistoryViewModel.swift
//  keia
//
//  Created by Antonio Lentini on 24/11/24.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var sorting: SortDescriptor<PurchaseIntent>
    @Published var searchTerm = ""
    
    @Published var focusedPurchase: PurchaseIntent? {
        didSet {
            if focusedPurchase != nil {
                purchaseIntentSheetOpen = true
            } else {
                purchaseIntentSheetOpen = false
            }
        }
    }
    
    @Published var purchaseIntentSheetOpen = false
    
    init(sorting: SortDescriptor<PurchaseIntent> = SortDescriptor(\.createdAt, order: .reverse)) {
        self.sorting = sorting
    }
}
