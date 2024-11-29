//
//  QuestionBinaryValuePicker.swift
//  keia
//
//  Created by Antonio Lentini on 22/11/24.
//

import SwiftUI

/// Shows two buttons to let the user answer to the ``Question``.
/// - Parameters:
///     - question: the question to answer to.
struct QuestionBinaryValuePicker: View {
    @Binding var question: Question
    
    var body: some View {
        HStack(spacing: 32) {
            Button(action: {
                question.fromBoolean(question.reversed)
            }) {
                Text("No")
            }
            .tint(Color("Prime"))
            .cornerRadius(1000)
            .buttonStyle(noButtonStyle(for: question.points, reversed: question.reversed))
            
            Button(action: {
                question.fromBoolean(!question.reversed)
            }) {
                Text("Yes")
                    
            }
            .tint(Color("Prime"))
            .cornerRadius(1000)
            .buttonStyle(yesButtonStyle(for: question.points, reversed: question.reversed))
        }
    }
}

extension QuestionBinaryValuePicker {
    func yesButtonStyle(for points: Double?, reversed: Bool) -> some PrimitiveButtonStyle {
        let isProminent = reversed ? points == 0 : points == 1
        return DynamicButtonStyle(isProminent: isProminent)
    }

    func noButtonStyle(for points: Double?, reversed: Bool) -> some PrimitiveButtonStyle {
        let isProminent = reversed ? points == 1 : points == 0
        return DynamicButtonStyle(isProminent: isProminent)
    }

}

struct DynamicButtonStyle: PrimitiveButtonStyle {
    var isProminent: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 92)
            .padding([.bottom, .top], 12)
            .background(isProminent ? Color("Prime") : Color("Prime").opacity(0.2))
            .foregroundColor(isProminent ? Color.white : Color("Prime"))
            .cornerRadius(8)
            .onTapGesture {
                configuration.trigger()
            }
    }
}

#Preview {
    QuestionBinaryValuePicker(
        question: .constant(
            Question(
                text: "Ciao",
                weight: 8.3,
                isSlider: false
            )
        )
    )
}
