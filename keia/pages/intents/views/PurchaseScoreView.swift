//
//  PurchaseScoreView.swift
//  keia
//
//  Created by Antonio Lentini on 22/11/24.
//

import SwiftUI
import SwiftData

/// View that shows the score of a `PurchaseIntent`.
struct PurchaseScoreView: View {
    @EnvironmentObject private var vm: CreatePurchaseIntentViewModel
    @Environment(\.modelContext) private var modelContext
    
    private var purchase: PurchaseIntent
    
    init(purchase: PurchaseIntent) {
        self.purchase = purchase
    }
    
    var textColor: Color {
        if purchase.score >= 6.0 {
            return .white
        }
        return .black
    }
    
    var backgroundColor: Color {
        if purchase.score >= 6.0 {
            return Color("Prime")
        }
        return .white
    }
    
    var buttonColor: Color {
        if purchase.score >= 6.0 {
            return .white
        }
        return Color("Prime")
    }
    
    var body: some View {
        VStack {
            Text("The product")
                .padding(.bottom, 4)
                .padding(.top, 64)
                .foregroundStyle(textColor)
            
            Text(purchase.product)
                .font(.system(size: 48))
                .fontWeight(.semibold)
                .padding(.bottom, 128)
                .foregroundStyle(textColor)
            
            Text("has a score equal to")
                .foregroundStyle(textColor)
            Text("\(purchase.score, specifier: "%.1f")")
                .foregroundStyle(textColor)
                .font(.system(size: 64))
                .fontWeight(.semibold)
                .padding(.bottom, 16)
                .padding(.top, 8)
            
            Text("that is...")
                .foregroundStyle(textColor)
            Text("you could buy it")
                .foregroundStyle(textColor)
                .fontWeight(.medium)
            
            Spacer()
            
            HStack(spacing: 32) {
                Button(action: {
                    vm.setPurchased(true, context: modelContext)
                }) {
                    Text("Purchase")
                        .padding([.top, .bottom], 4)
                }
                .tint(buttonColor)
                .foregroundStyle(buttonColor)
                .cornerRadius(1000)
                .buttonStyle(.bordered)

                
                Button(action: {
                    vm.setPurchased(false, context: modelContext)
                }) {
                    Text("Save")
                        .padding([.leading, .trailing], 16)
                        .padding([.top, .bottom], 4)
                }
                .tint(buttonColor)
                .foregroundStyle(buttonColor)
                .cornerRadius(1000)
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden()
        .background(backgroundColor)
    }
}

#Preview {
    PurchaseScoreView(
        purchase: PurchaseIntent(
            product: "Prodotto",
            price: 35.2,
            score: 5,
            purchased: true,
            questions: Array<PurchaseQuestion>()
        )
    )
}
