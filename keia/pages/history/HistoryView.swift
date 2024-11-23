//
//  HistoryView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct HistoryView: View {
    
    var objects: [PurchaseIntent]
    var body: some View {
        VStack {
            ScrollView{
                ForEach(objects, id: \.id){ object in
                    GroupBox(label: Text(object.product)){
                        HStack {
                            VStack(alignment: .leading){
                                Text("\(object.price, specifier: "%.2f")€")
                                Text("20/09/2024")
                            }
                            Spacer()
                            Text("\(object.score, specifier: "%.2f")")
                        }
                    }
                    .groupBoxStyle(.items)
                    
                    
                }
            }
        }
    }
}

#Preview {
    HistoryView(objects: [PurchaseIntent(product: "Mac Book Pro M4 Pro", price: 4200, score: 7.7, purchased: false), PurchaseIntent(product: "iPhone 16", price: 890, score: 8.9, purchased: false)])
}

struct objectsGroupBoxStyle : GroupBoxStyle {
    var backgroundColor: UIColor = UIColor .systemGroupedBackground
    var width: CGFloat = 325
    var labelColor: UIColor = UIColor.label
    var opacity: Double = 1
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading){
            HStack {
                configuration.label
                    .font(Font.bold(.body)())
                    .foregroundColor(Color(labelColor))
                    //.padding()
            }
            configuration.content
        }
        .frame(width: width)
        .padding()
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color(backgroundColor)))
        .opacity(opacity)
    }
}

extension GroupBoxStyle where Self == objectsGroupBoxStyle{
    static var items:  objectsGroupBoxStyle{
        .init()
    }
}

