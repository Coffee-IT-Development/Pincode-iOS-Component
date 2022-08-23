//
//  CITPincodeTextField.swift
//  
//  MIT License
//
//  Copyright (c) 2022 Coffee IT
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
