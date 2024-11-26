//
//  PurchaseDetailView.swift
//  keia
//
//  Created by Miriam Listì on 25/11/24.
//

import SwiftUI

struct PurchaseDetailView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var hvm: HistoryViewModel
    
    let purchase: PurchaseIntent
    
    init(purchase: PurchaseIntent) {
        self.purchase = purchase
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Spacer(minLength: 30)
                    Text(purchase.product)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.center)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("(\(purchase.price, specifier: "%.2f")$)")
                        .font(.system(size: 20))
                    Spacer()
                    HStack{
                        Text("\(purchase.score, specifier: "%.1f")")
                            .font(.system(size: 50))
                            .fontWeight(.semibold)
                            .foregroundStyle(getScoreColor())
                            .padding(.bottom, 16)
                            .padding(.top, 8)
                        Text("/ 10")
                            .font(.system(size: 20))
                        
                    }
                    GroupBox{
                        ForEach(purchase.questions, id:\.id) { question in
                            HStack{
                                Text(question.text)
                                    .padding()
                                Spacer()
                                Text(getPointForQuestion(question: question))
                                    .foregroundStyle( .white)
                                    .frame(width: 70, height: 35)
                                    .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(getScoreColor()))
                            }
                            Divider()
                            
                        }
                    }
                    .groupBoxStyle(.item)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Text("On \(getDate()) you wanted to buy:")
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        context.delete(purchase)
                        hvm.focusedPurchase = nil
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.black)
                            .imageScale(.medium)
                    }
                }
            }
        }
    }
}

extension PurchaseDetailView {
    func getScoreColor() -> Color {
        if purchase.score >= 8.0 {
            return Color("Prime")
        } else if purchase.score >= 6.0 {
            return Color("Prime").opacity(0.5)
        }
        return .gray
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMdy")
        
        return formatter.string(from: purchase.createdAt)
    }
    
    func getPointForQuestion(question: PurchaseQuestion) -> String {
        if question.isSlider {
            return "\((question.points) * 5)"
        }
        return question.points == 1 ? "Yes" : "No"
    }
}

fileprivate struct ObjectsGroupBoxStyle : GroupBoxStyle {
    var backgroundColor: UIColor = UIColor.white
    var labelColor: UIColor = UIColor.label
    var opacity: Double = 1
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            configuration.label
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color(labelColor))
            
            configuration.content
        }
        .padding(.horizontal)
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
    PurchaseDetailView(
        purchase: PurchaseIntent(
            product: "Mac Book Pro M4 Pro",
            price: 4200,
            score: 5,
            purchased: false,
            questions: [
                PurchaseQuestion(text: "Ciao", weight: 6.4, isSlider: true, reversed: false, points: 0.4),
                PurchaseQuestion(text: "Bella ciao", weight: 6.4, isSlider: false, reversed: false, points: 1),
            ]
        )
    )
}
