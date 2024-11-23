//
//  PageIndicator.swift
//  keia
//
//  Created by Antonio Lentini on 22/11/24.
//

import SwiftUI

/// Indicates to the user the progress he has made in answering the ``Question``s.
struct PageIndicator: View {
    @EnvironmentObject private var vm: CreatePurchaseIntentViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { n in
                PageDot(
                    isColored: isColored(for: n),
                    isCurrent: vm.currentPage == n
                )
            }
        }
    }
    
    private var totalPages: Int {
        vm.questions.count + 2
    }
    
    private func isColored(for index: Int) -> Bool {
        switch index {
        case 0:
            return !vm.product.isEmpty
        case 1:
            return !vm.price.isEmpty
        case 2..<totalPages:
            return vm.questions[index - 2].points != nil
        default:
            return false
        }
    }
}

private struct PageDot: View {
    let isColored: Bool
    let isCurrent: Bool
    
    var body: some View {
        Rectangle()
            .frame(width: isCurrent ? 30 : 10, height: 10)
            .cornerRadius(1000)
            .foregroundStyle(isColored ? Color("Prime") : .gray)
    }
}
