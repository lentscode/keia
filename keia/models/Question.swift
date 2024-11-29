//
//  Question.swift
//  keia
//
//  Created by Antonio Lentini on 21/11/24.
//

import Foundation

/// Class representing a question asked to the user about a
/// ``PurchaseIntent``.
struct Question: Identifiable {
    /// Unique id of the question.
    let id = UUID()
    /// The question itself.
    let text: String
    /// The importance of the question.
    let weight: Double
    /// Whether the question is answered via a ``QuestionValuePicker``.
    let isSlider: Bool
    /// In case the question accepts a value via a `Bool`,
    /// assigns a value of 1 to 'no' and 0 to 'yes'.
    let reversed: Bool
    /// The points assigned to the question depending on user answer.
    private(set) var points: Double?
    
    init(text: String, weight: Double, isSlider: Bool, reversed: Bool = false) {
        self.text = text
        self.weight = weight
        self.isSlider = isSlider
        self.reversed = reversed
    }
    
    /// Assigns a value to ``points`` depending on a `Bool` value.
    mutating func fromBoolean(_ decision: Bool) {
        if reversed {
            points = decision ? 0 : 1
        } else {
            points = decision ? 1 : 0
        }
    }
    
    /// Assigns a value to ``points`` depending on a `Int` value.
    mutating func fromSlider(_ value: Int) {
        guard value >= 1 && value <= 5 else {
            return
        }
        
        if reversed {
            points = 1 - (Double(value) - 1) / 5.0
        } else {
            points = Double(value) / 5.0
        }
    }
    
    /// Resets the ``points`` of a question.
    mutating func reset() {
        points = nil
    }
}
