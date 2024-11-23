//
//  PurchaseIntentCard.swift
//  keia
//
//  Created by Antonio Lentini on 23/11/24.
//

import SwiftUI

struct PurchaseIntentCard: View {
    private let purchase: PurchaseIntent
    
    init(purchase: PurchaseIntent) {
        self.purchase = purchase
    }
    
    var body: some View {
        GroupBox(label: Text(purchase.product)) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("\(purchase.price, specifier: "%.2f")€")
                        .padding(.bottom, 2)
                    Text(getDate())
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text("\(purchase.score, specifier: "%.1f")")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(getScoreColor())
            }
        }
        .groupBoxStyle(.item)
    }
}

extension PurchaseIntentCard {
    func getScoreColor() -> Color {
        if purchase.score >= 8.0 {
            return Color("Prime")
        } else if purchase.score >= 6.0 {
            return Color("Prime").opacity(0.5)
        }
        return .black
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMdy")
        
        return formatter.string(from: purchase.createdAt)
    }
}

fileprivate struct ObjectsGroupBoxStyle : GroupBoxStyle {
    var backgroundColor: UIColor = UIColor.systemGroupedBackground
    var labelColor: UIColor = UIColor.label
    var opacity: Double = 1
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            configuration.label
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color(labelColor))
            
            configuration.content
        }
        .frame(width: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(backgroundColor))
        )
        .opacity(opacity)
    }
}

extension GroupBoxStyle where Self == ObjectsGroupBoxStyle{
    static var item: ObjectsGroupBoxStyle{ .init() }
}

#Preview {
    PurchaseIntentCard(
        purchase: PurchaseIntent(product: "Mac Book Pro M4 Pro", price: 4200, score: 7.7, purchased: false)
    )
    .padding([.leading, .trailing], 16)
}
