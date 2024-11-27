//
//  CreationProcessView.swift
//  keia
//
//  Created by Antonio Lentini on 21/11/24.
//

import SwiftUI

/// View that shows all the questions leading to the creation of a `PurchaseIntent`.
struct CreationProcessView: View {
    @EnvironmentObject private var vm: CreatePurchaseIntentViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $vm.currentPage) {
                Page(productName)
                    .tag(0)
                
                Page(productPrice)
                    .tag(1)
                
                ForEach(vm.questions.indices, id: \.self) { index in
                    Page(questionView(index: index))
                        .tag(index + 2)
                }
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .automatic)
            )
            
            Button(
                action: {
                    vm.createPurchase()
                }, label: {
                    Text("Confirm")
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                })
            .cornerRadius(1000)
            .padding(.bottom, 32)
            .tint(Color("Prime"))
            .buttonStyle(.borderedProminent)
            .opacity(vm.isComplete ? 1 : 0)
            
            PageIndicator()
                .padding(.bottom, 32)
        }
    }
    
    private var productName: some View {
        VStack {
            Text("What would you like to buy?")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            TextField("Product name", text: $vm.product)
                .multilineTextAlignment(.center)
                .tint(Color("Prime"))
                .font(.title2)
        }
    }
    
    private var productPrice: some View {
        VStack {
            Text("How much does it cost?")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            TextField("0.0", text: $vm.price)
                .keyboardType(.numbersAndPunctuation)
                .multilineTextAlignment(.center)
                .tint(Color("Prime"))
                .font(.title2)
        }
    }
    
    @ViewBuilder private func questionView(index: Int) -> some View {
        VStack {
            Text(vm.questions[index].text)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            if vm.questions[index].isSlider {
                QuestionValuePicker(question: $vm.questions[index])
            } else {
                QuestionBinaryValuePicker(
                    question: $vm.questions[index]
                )
            }
        }
    }
    
    private func Page<Content: View>(_ content: Content) -> some View {
        content
            .padding([.leading, .trailing], 32)
    }
}

#Preview {
    let questions: [Question] = [
        Question(text: "Text", weight: 0.9, isSlider: true),
    ]
    
    let vm = CreatePurchaseIntentViewModel(questions: questions)
    
    CreationProcessView().environmentObject(vm)
}

