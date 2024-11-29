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
        .groupBoxStyle(.item(purchased: purchase.purchased))
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
    
    private var purchased: Bool
    
    init(purchased: Bool) {
        self.purchased = purchased
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                configuration.label
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color(labelColor))
                
                configuration.content
            }
            .padding()
            
            if purchased {
                ZStack() {
                    RoundedRectangle(cornerRadius: 0)
                        .clipShape(
                            RoundedCorners(
                                tl: 0,
                                tr: 0,
                                bl: 16,
                                br: 16
                            )
                        )
                        .frame(height: 32)
                        .foregroundStyle(Color("Prime"))
                    Text("Purchased")
                        .foregroundStyle(.white)
                }
            }
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(backgroundColor))
            }
        )
    }
}

extension GroupBoxStyle where Self == ObjectsGroupBoxStyle{
    static func item(purchased: Bool) -> ObjectsGroupBoxStyle{
        .init(purchased: purchased)
    }
}

fileprivate struct RoundedCorners: Shape {
    var tl: CGFloat = 0
    var tr: CGFloat = 0
    var bl: CGFloat = 0
    var br: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerRadii: RectangleCornerRadii(
                topLeading: tl,
                bottomLeading: bl,
                bottomTrailing: br,
                topTrailing: tr
            )
        )
        return path
    }
}

#Preview {
    PurchaseIntentCard(
        purchase: PurchaseIntent(
            product: "Mac Book Pro M4 Pro",
            price: 4200,
            score: 7.7,
            purchased: true,
            questions: Array<PurchaseQuestion>()
        )
    )
    .padding([.leading, .trailing], 16)
}
