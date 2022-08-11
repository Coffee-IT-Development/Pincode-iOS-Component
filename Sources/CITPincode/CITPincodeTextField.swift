//
//  CITPincodeTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct CITPincodeTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        private let pincodeTextField: CITPincodeTextField

        init(_ pincodeTextField: CITPincodeTextField) {
            self.pincodeTextField = pincodeTextField
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.pincodeTextField.text = textField.text ?? ""
            }
        }
    }
    
    @Binding var text: String
    var config: CITPincodeView.Configuration
    var setup: (CITPincodePasteOnlyTextField) -> Void
    
    init(text: Binding<String>, config: CITPincodeView.Configuration, setup: @escaping (CITPincodePasteOnlyTextField) -> Void) {
        self._text = text
        self.config = config
        self.setup = setup
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = CITPincodePasteOnlyTextField()
        setup(textField)
        textField.keyboardType = config.keyboardType
        textField.textContentType = .oneTimeCode
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.keyboardType = config.keyboardType
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
