//
//  ViewExtensions.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import SwiftUI

extension View {
    /// Enables the ``CreationProcessView`` sheet for a page of the ``MainTab``
    func purchaseSheet(
        isCreationProcessPresented: Binding<Bool>,
        isPurchaseScorePresented: Binding<Bool>,
        purchase: PurchaseIntent?
    ) -> some View {
        sheet(isPresented: isCreationProcessPresented) {
            CreationProcessView()
        }
        .sheet(isPresented: isPurchaseScorePresented) {
            if let purchase {
                PurchaseScoreView(purchase: purchase)
            }
        }
    }
}
