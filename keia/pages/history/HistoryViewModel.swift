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
    
    init(sorting: SortDescriptor<PurchaseIntent> = SortDescriptor(\.createdAt, order: .reverse)) {
        self.sorting = sorting
    }
}
