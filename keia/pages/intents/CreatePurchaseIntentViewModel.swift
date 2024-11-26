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
    @Published var price = ""
    
    /// Flag that enables the `CreationProcessView` sheet.
    @Published var isCreationProcessPresented: Bool = false
    /// Flag that enables the `PurchaseScoreView` sheet.
    @Published var isPurchaseScorePresented: Bool = false
    /// The purchase object created.
    @Published var purchase: PurchaseIntent? {
        didSet {
            if purchase != nil {
                closeCreationAndOpenScore()
            }
        }
    }
    
    /// Returns a boolean depending on wheter all fields of the form were compiled.
    var isComplete: Bool {
        if product.isEmpty || price.isEmpty {
            return false
        }
        
        for question in questions {
            if question.points == nil {
                return false
            }
        }
        
        return true
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
    
    private func reset() {
        currentPage = 0
        product = ""
        price = ""
        isCreationProcessPresented = false
        isPurchaseScorePresented = false
        purchase = nil
        
        for question in questions {
            question.reset()
        }
    }
    
    /// Sets the value of the `Question` at `index` using a value between 1 to 5.
    func evaluateQuestion(index: Int, value: Int) {
        questions[index].fromSlider(value)
    }
    
    /// Sets the value of the `Question` at `index` using a boolean.
    func evaluateQuestion(index: Int, value: Bool) {
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
        purchase = PurchaseIntent(
            product: product,
            price: Double(price) ?? 0,
            score: 0,
            purchased: false,
            questions: questions
        )
        
        let formData = PurchaseFormData(questions: questions)
        
        ScoreCalculator(purchase: purchase!, formData: formData).calculateScoreOfPurchase()
    }
}
