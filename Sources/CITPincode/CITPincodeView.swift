//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI
import SwiftUIX // Can be removed when we only support iOS 14+
import Introspect

public struct CITPincodeView: View {
    @Binding var code: String
    @Binding var busyCheckingCode: Bool
    @Binding var error: String?
    
    private let config: CITPincodeConfig
    private let onEnteredCode: (String) -> Void
    private let onResendCode: () -> Void
    
    @State private var enteredCode = ""
    @State private var codeInputField: UITextField?
    @State private var shownKeyboardOnce = false
    
    var hasError: Bool {
        error != nil
    }
    
    public init(
        code: Binding<String>,
        busyCheckingCode: Binding<Bool> = .constant(false),
        error: Binding<String?> = .constant(nil),
        config: CITPincodeConfig,
        onEnteredCode: @escaping (String) -> Void,
        onResendCode: @escaping () -> Void
    ) {
        self._code = code
        self._busyCheckingCode = busyCheckingCode
        self._error = error
        self.config = config
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
                        CITPincodeDivider(config: config)
                    }
                }
            }
            .overlay(
                GeometryReader { proxy in
                    TextField("", text: $code)
                        .keyboardType(config.codeType)
                        .textContentType(.oneTimeCode)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .opacity(0)
                        .allowsHitTesting(false)
                }
            )
            .introspectTextField { textField in
                codeInputField = textField
                codeInputField?.addDoneButton()
                showKeyboardInitially()
                setupEditMenu()
            }
            .onTapGesture {
                codeInputField?.becomeFirstResponder()
            }
            .onLongPressGesture {
                showPasteMenu()
            }
            
            if config.resendButton.showButton {
                CITPincodeResendButton(
                    config: config,
                    onResendCode: handleResendCode
                )
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
    
    private func showKeyboardInitially() {
        guard !shownKeyboardOnce else {
            return
        }
        shownKeyboardOnce = true
        codeInputField?.becomeFirstResponder()
    }
    
    private func setupEditMenu() {
        if #available(iOS 16.0, *) {
            guard let codeInputField = codeInputField else {
                return
            }
            
            EditMenuHelper.shared.setupPasteEditMenu(for: codeInputField)
        }
    }
    
    private func showPasteMenu() {
        guard let codeInputField = codeInputField,
              var clipboardText = UIPasteboard.general.string else {
            return
        }
        
        clipboardText = clipboardText.replacingOccurrences(of: "-", with: "")
        guard config.codeLength == clipboardText.count,
              config.codeType != .numberPad || clipboardText.isNumber else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            return
        }
        
        if #available(iOS 16.0, *) {
            EditMenuHelper.shared.showEditMenu(in: codeInputField.frame)
        } else {
            UIMenuController.shared.showMenu(from: codeInputField, rect: codeInputField.frame)
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
            config: .socialBlox,
            onEnteredCode: { _ in },
            onResendCode: {}
        )
    }
}
