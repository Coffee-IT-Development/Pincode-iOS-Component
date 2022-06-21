//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI
import SwiftUIX
import Introspect

public struct CITPincodeView: View {
    @Binding var code: String
    @Binding var busyCheckingCode: Bool
    @Binding var error: String?
    @Binding var config: CITPincodeConfig
    var onEnteredCode: (String) -> Void
    var onResendCode: () -> Void
    
    var hasError: Bool {
        error != nil
    }
    
    @State private var enteredCode = ""
    @State private var codeInputField: UITextField?
    
    public init(
        code: Binding<String>,
        busyCheckingCode: Binding<Bool> = .constant(false),
        error: Binding<String?> = .constant(nil),
        config: Binding<CITPincodeConfig>,
        onEnteredCode: @escaping (String) -> Void,
        onResendCode: @escaping () -> Void
    ) {
        self._code = code
        self._busyCheckingCode = busyCheckingCode
        self._error = error
        self._config = config
        self.onEnteredCode = onEnteredCode
        self.onResendCode = onResendCode
    }
    
    public var body: some View {
        VStack(alignment: config.resendButtonStyle.alignment) {
            HStack {
                ForEach((0 ..< config.codeLength), id: \.self) { i in
                    CITPincodeCellView(
                        config: config,
                        character: character(for: i),
                        placeholder: placeholder(for: i),
                        isSelected: i == code.count,
                        hasError: hasError
                    )
                    
                    if config.dividerStyle.afterIndex == i {
                        config.dividerView
                    }
                }
            }
            .background(
                TextField("", text: $code)
                    .keyboardType(config.codeType)
                    .textContentType(.oneTimeCode)
                    .opacity(0)
                    .allowsHitTesting(false)
            )
            .introspectTextField { textField in
                codeInputField = textField
                codeInputField?.becomeFirstResponder()
                codeInputField?.addDoneButton()
            }
            .onTapGesture {
                codeInputField?.becomeFirstResponder()
            }
            
            if config.resendButton.showButton {
                CITPincodeResendButton(config: config, onResendCode: handleResendCode)
            }
            
            if let error = error {
                Text(error)
                    .foregroundColor(config.errorColor)
                    .font(config.errorFont)
                    .padding(.vertical, 8)
            }
        }
        .onChange(of: code) { newValue in
            if newValue.count == config.codeLength && newValue != enteredCode {
                handleEnteredCode()
            } else if newValue.count > config.codeLength {
                code = String(newValue.prefix(config.codeLength))
            } else if newValue.count < config.codeLength {
                enteredCode = ""
                error = nil
            }
        }
    }
    
    private func handleEnteredCode() {
        enteredCode = code
        onEnteredCode(code)
    }
    
    private func handleResendCode() {
        code = ""
        onResendCode()
    }
    
    private func character(for index: Int) -> Character? {
        code.count > index ? code[code.index(code.startIndex, offsetBy: index)] : nil
    }
    
    private func placeholder(for index: Int) -> Character? {
        let text = config.placeholder
        return text.count > index ? text[text.index(text.startIndex, offsetBy: index)] : nil
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(
            code: .constant(""),
            config: .constant(.socialBlox),
            onEnteredCode: { _ in },
            onResendCode: {}
        )
    }
}
