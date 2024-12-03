//
//  HistoryView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var vm: CreatePurchaseIntentViewModel
    @EnvironmentObject private var hvm: HistoryViewModel
    
    var body: some View {
        NavigationStack {
            HistoryPurchaseList(sorting: hvm.sorting, filter: hvm.searchTerm)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("Sort", selection: $hvm.sorting) {
                                Text("Date")
                                    .tag(
                                        SortDescriptor(
                                            \PurchaseIntent.createdAt,
                                             order: .reverse
                                        )
                                    )
                                Text("Name")
                                    .tag(SortDescriptor(\PurchaseIntent.product))
                                Text("Price")
                                    .tag(
                                        SortDescriptor(
                                            \PurchaseIntent.price,
                                             order: .reverse
                                        )
                                    )
                                Text("Score")
                                    .tag(
                                        SortDescriptor(
                                            \PurchaseIntent.score,
                                             order: .reverse
                                        )
                                    )
                            }
                            .pickerStyle(.inline)
                        } label: {
                            Image(systemName:"line.3.horizontal.decrease")
                                .foregroundColor(.black)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            vm.isCreationProcessPresented = true
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("Prime"))
                                .font(.title3)
                        })
                    }
                }
                .navigationTitle("History")
        }
        .searchable(text: $hvm.searchTerm)
        .purchaseSheet(
            isCreationProcessPresented: $vm.isCreationProcessPresented,
            isPurchaseScorePresented: $vm.isPurchaseScorePresented,
            purchase: vm.purchase,
            dismissAction: vm.reset
        )
        .sheet(isPresented: $hvm.purchaseIntentSheetOpen) {
            if let purchase = hvm.focusedPurchase {
                PurchaseDetailView(purchase: purchase)
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

