//
//  PurchaseDetailView.swift
//  keia
//
//  Created by Miriam Listì on 25/11/24.
//

import SwiftUI

struct PurchaseDetailView: View {

    
    let purchase: PurchaseIntent
    let questions = [Question(text: "Questa è una domanda", weight: 1, isSlider: true), Question(text: "Queta è un'altra domanda", weight: 1, isSlider: true)]
    
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
                        Text("/10")
                            .font(.system(size: 20))
                        
                    }
                    GroupBox{
                        ForEach(questions, id:\.id){ question in
                            HStack{
                                Text(question.text)
                                    .padding()
                                Spacer()
                                Text("YES")
                                    .foregroundStyle( .white)
                                    .frame(width: 70, height: 35)
                                    .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color(getScoreColor())))
                            }
                            Divider()
                            
                        }
                        
                    }
                    .groupBoxStyle(.item)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Text("On \(getDate()) you wantetd to buy:")
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: //todo
                           {
                           
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundColor(.black)
                            .imageScale(.medium)

                    })
                }
            }
        }
           
        
    }
}

#Preview {
    PurchaseDetailView(purchase: PurchaseIntent(product: "Mac Book Pro M4 Pro", price: 4200, score: 7.7, purchased: false))
}

extension PurchaseDetailView {
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




