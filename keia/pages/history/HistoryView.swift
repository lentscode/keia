//
//  HistoryView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query private var purchases: [PurchaseIntent]
    @State private var searchTerm = ""
    @EnvironmentObject private var vm: CreatePurchaseIntentViewModel
    
    var body: some View {
            NavigationStack {
                ScrollView {
                    ForEach(purchases, id: \.id) { purchase in
                        PurchaseIntentCard(purchase: purchase)
                        .padding(.bottom, 8)
                        .padding([.leading, .trailing], 16)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Menu {
                            Button( action: {//toDo
                            }) {
                                Text("Date")
                                }
                                Button( action: {//toDo
                                }) {
                                Text("Name")
                                }
                                Button( action: {//toDo
                                }) {
                                Text("Price")
                                }
                                Button( action: {//toDo
                                }) {
                                Text("Score")
                                }
                                } label: {
                                Image(systemName:"line.3.horizontal.decrease")
                                        .foregroundColor(.black)
                                }
                    })
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            vm.isCreationProcessPresented = true
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("Prime"))
                        })
                    }
                }
                .navigationTitle("History")
            }
            .searchable(text: $searchTerm)
            .purchaseSheet(
                isCreationProcessPresented: $vm.isCreationProcessPresented,
                isPurchaseScorePresented: $vm.isPurchaseScorePresented,
                purchase: vm.purchase
            )
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: [PurchaseIntent.self])
        .environmentObject(CreatePurchaseIntentViewModel(questions: [Question(text:"Does this product solve an urgent need?", weight: 6, isSlider: false), Question(text:"Has the best quality/price ratio?", weight: 4, isSlider: true)]))
}

