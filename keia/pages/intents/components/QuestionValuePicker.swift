//
//  QuestionValuePicker.swift
//  keia
//
//  Created by Antonio Lentini on 22/11/24.
//

import SwiftUI

/// Components that shows five circles representing value
/// to give to a `Question`.
///
/// - Parameters:
///     - question: question to answer with a value
struct QuestionValuePicker: View {
    @Binding var question: Question
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(1...5, id: \.self) {n in
                Text("\(n)")
                    .foregroundStyle(isValue(n) ? Color("Prime") : .black)
                    .frame(width: 20, height: 20)
                    .padding()
                    .overlay {
                        Circle()
                            .stroke(isValue(n) ? Color("Prime") : .black, lineWidth: 2)
                    }
                    .onTapGesture {
                        question.fromSlider(n)
                    }
            }
        }
    }
    
    func isValue(_ n: Int) -> Bool {
        if question.points == nil {
            return false
        }
        
        if question.reversed {
            return 6 - Int(5 * question.points!) == n
        }
        
        return Int(question.points! * 5.0) == n
    }
}

#Preview {
    QuestionValuePicker(
        question: .constant(
            Question(
            text: "Ciao",
            weight: 0.6,
            isSlider: true
            )
        )
    )
}
