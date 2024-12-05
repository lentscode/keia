//
//  CreatePurchaseIntentViewModel.swift
//  keia
//
//  Created by Antonio Lentini on 21/11/24.
//

import Foundation
import SwiftData

/// View Model to manage `PurchaseIntent` creation.
/// - Parameters:
///     - questions: the questions to ask the user to calculate the purchase score.
class CreatePurchaseIntentViewModel: ObservableObject {
    @Published var questions: [Question]
    
    /// The current page of the `CreationProcessView`.
    @Published var currentPage = 0
    /// The name of the product.
    @Published var product = ""
    /// The price (in `String`) of the product.
    @Published var price: Double?
    
    /// Flag that enables the `CreationProcessView` sheet.
    @Published var isCreationProcessPresented: Bool = false
    /// Flag that enables the `PurchaseScoreView` sheet.
    @Published var isPurchaseScorePresented: Bool = false
    /// The purchase object created.
    @Published var purchase: PurchaseIntent? {
        didSet {
            if purchase != nil {
                isCreationProcessPresented = false
                isPurchaseScorePresented = true
            }
        }
    }
    
    /// Returns a boolean depending on wheter all fields of the form were compiled.
    var isComplete: Bool {
        !product.isEmpty && price != nil && questions.allSatisfy { $0.points != nil }
    }
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    private func closeCreationAndOpenScore() {
        isCreationProcessPresented = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isPurchaseScorePresented = true
        }
    }
    
    func reset() {
        currentPage = 0
        product = ""
        price = 0.0
        isCreationProcessPresented = false
        isPurchaseScorePresented = false
        purchase = nil
        
        resetQuestions()
    }
    
    private func resetQuestions() {
        questions = questions.map { question in
            var q = question
            q.reset()
            return q
        }
    }
    
    /// Sets the value of the `Question` at `index` using a value between 1 to 5.
    func evaluateQuestion(index: Int, value: Int) {
        guard questions.indices.contains(index) else { return }
        questions[index].fromSlider(value)
    }
    
    /// Sets the value of the `Question` at `index` using a boolean.
    func evaluateQuestion(index: Int, value: Bool) {
        guard questions.indices.contains(index) else { return }
        questions[index].fromBoolean(value)
    }
    
    /// Sets the `purchased` field of the `PurchaseIntent` and creates an object
    /// inside the local DB.
    func setPurchased(_ purchased: Bool, context: ModelContext) {
        if let purchase {
            purchase.purchased = purchased
            
            context.insert(purchase)
        }
        reset()
    }
    
    /// Creates a `PurchaseIntent` object and puts it inside `purchase`.
    func createPurchase() {
        questions.sort(by: {$0.text < $1.text})
        
        purchase = PurchaseIntent(
            product: product,
            price: price!,
            score: 0,
            purchased: false,
            questions: questions
        )
        
        let formData = PurchaseFormData(questions: questions)
        
        ScoreCalculator(purchase: purchase!, formData: formData).calculateScoreOfPurchase()
    }
}
