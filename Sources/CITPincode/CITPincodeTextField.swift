//
//  CITPincodeTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//

import SwiftUI

public struct CITPincodeTextField: UIViewRepresentable {
    @Binding var text: String
    var config: CITPincodeConfig
    
    public init(
        text: Binding<String>,
        config: CITPincodeConfig
    ) {
        self._text = text
        self.config = config
    }

    public func makeUIView(context: Context) -> UITextField {
        let textField = CITPincodePasteOnlyTextField()
        textField.keyboardType = config.codeType
        textField.textContentType = .oneTimeCode
        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}
