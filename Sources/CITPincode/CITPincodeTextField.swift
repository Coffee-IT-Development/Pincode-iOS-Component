//
//  CITPincodeTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//

import SwiftUI

struct CITPincodeTextField: UIViewRepresentable {
    @Binding var text: String
    var config: CITPincodeConfig
    var configure: (CITPincodePasteOnlyTextField) -> Void

    func makeUIView(context: Context) -> UITextField {
        let textField = CITPincodePasteOnlyTextField()
        textField.keyboardType = config.codeType
        textField.textContentType = .oneTimeCode
        configure(textField)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}
