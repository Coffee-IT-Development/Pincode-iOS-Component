//
//  CITPincodeTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public struct CITPincodeTextField: UIViewRepresentable {
    @Binding var text: String
    var config: CITPincodeView.Configuration
    var setup: (CITPincodePasteOnlyTextField) -> Void
    
    public init(text: Binding<String>, config: CITPincodeView.Configuration, setup: @escaping (CITPincodePasteOnlyTextField) -> Void) {
        self._text = text
        self.config = config
        self.setup = setup
    }

    public func makeUIView(context: Context) -> UITextField {
        let textField = CITPincodePasteOnlyTextField()
        setup(textField)
        textField.keyboardType = config.codeType
        textField.textContentType = .oneTimeCode
        textField.delegate = context.coordinator
        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.keyboardType = config.codeType
        uiView.text = text
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        private let pincodeTextField: CITPincodeTextField

        public init(_ pincodeTextField: CITPincodeTextField) {
            self.pincodeTextField = pincodeTextField
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.pincodeTextField.text = textField.text ?? ""
            }
        }
    }
}
