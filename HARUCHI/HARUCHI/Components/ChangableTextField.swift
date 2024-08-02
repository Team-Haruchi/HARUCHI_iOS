//
//  ChangableTextField.swift
//  HARUCHI
//
//  Created by 채리원 on 7/31/24.
//

import SwiftUI
import UIKit

/// Color changable
struct ChangableTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var font: UIFont
    var isValid: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isValid: isValid)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.font = font
        textField.textColor = isValid ? UIColor.black : UIColor.red
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.textColor = isValid ? UIColor.black : UIColor.red
    }
}

class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String
    var isValid: Bool
    
    init(text: Binding<String>, isValid: Bool) {
        _text = text
        self.isValid = isValid
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        print("!!!!!!!!")
        text = textField.text ?? ""
        textField.textColor = isValid ? UIColor.black : UIColor.red
    }
}
