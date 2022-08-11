//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

/// The CITPincodeView provides a simple One Time Passcode interface with deep customization through its configuration.
/// It includes an optional resend code button with built-in cooldown logic, an error label that's dynamically shown and error color tints, callbacks for when a code has been entered and when the resend code button is pressed and long press to paste logic that filters hyphens and denies codes of the wrong type, e.g. pasting letters into a numeric code.
public struct CITPincodeView: View {
    @Binding var code: String
    @Binding var error: String?
    @Binding var forceCooldownOnce: Bool
    
    private let configuration: CITPincodeView.Configuration
    private let onEnteredCode: () -> Void
    private let onResendCode: () -> Void
    
    @State private var enteredCode = ""
    @State private var codeInputField: UITextField?
    @State private var shownKeyboardOnceInitially = false
    
    var hasError: Bool {
        error != nil
    }
    
    /// Intialise the pincode view with bindings, a configuration and callbacks.
    /// - Parameters:
    ///   - code: Text binding for code input.
    ///   - error: Optional error binding for displaying error messages below the pincode view and showing error tint colors.
    ///   - forceCooldownOnce: Used to trigger resendButton cooldown once whenever set to true. This may be useful if you'd like to manually send a code onAppear or any other moment, so that the resendButton goes on cooldown when appropriate.
    ///   - configuration: Used to configure various visual and functional aspects of the pincode view.
    ///   - onEnteredCode: Called when a code has been entered, i.e. "code.count" equals "configuration.codeLength".
    ///   - onResendCode: Called when the resend code button is pressed, the button is disabled on press for the given cooldown duration.
    public init(
        code: Binding<String>,
        error: Binding<String?> = .constant(nil),
        forceCooldownOnce: Binding<Bool>,
        configuration: CITPincodeView.Configuration,
        onEnteredCode: @escaping () -> Void,
        onResendCode: @escaping () -> Void
    ) {
        _code = code
        _error = error
        _forceCooldownOnce = forceCooldownOnce
        self.configuration = configuration
        self.onEnteredCode = onEnteredCode
        self.onResendCode = onResendCode
    }
    
    public var body: some View {
        VStack(alignment: configuration.resendButtonStyle.alignment) {
            HStack {
                ForEach(0 ..< configuration.codeLength, id: \.self) { index in
                    CITPincodeCellView(
                        configuration: configuration,
                        character: character(for: index),
                        placeholder: placeholder(for: index),
                        isSelected: index == code.count,
                        hasError: hasError
                    )
                    
                    if configuration.dividerStyle.afterIndex == index {
                        CITPincodeDivider(configuration: configuration)
                    }
                }
            }
            .background(
                GeometryReader { proxy in
                    CITPincodeTextField(
                        text: $code,
                        configuration: configuration,
                        setup: setupPasteOnlyTextField
                    )
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .opacity(0)
                    .allowsHitTesting(false)
                }
            )
            .onTapGesture {
                codeInputField?.becomeFirstResponder()
            }
            .onLongPressGesture {
                showPasteMenu()
            }
            
            if configuration.resendButton.showButton {
                CITPincodeResendButton(
                    forceCooldownOnce: $forceCooldownOnce,
                    configuration: configuration,
                    action: handleResendCode
                )
                .accessibility(label: Text(configuration.resendButtonStyle.text))
            }
            
            if let error = error {
                Text(error)
                    .foregroundColor(configuration.errorColor)
                    .font(configuration.errorFont)
                    .padding(.vertical, 8)
                    .accessibility(label: Text(error))
            }
        }
        .onChange(of: code) { newValue in
            if newValue.count == configuration.codeLength && newValue != enteredCode {
                handleEnteredCode()
            } else if newValue.count > configuration.codeLength {
                code = String(newValue.prefix(configuration.codeLength))
            } else if newValue.count < configuration.codeLength {
                enteredCode = ""
                error = nil
            }
        }
    }
    
    private func setupPasteOnlyTextField(_ textField: UITextField) {
        DispatchQueue.main.async {
            codeInputField = textField
            textField.addDoneButton(configuration.keyboardDoneButtonText)
            showKeyboardInitially()
        }
    }
    
    private func showKeyboardInitially() {
        guard !shownKeyboardOnceInitially && configuration.showKeyboardOnAppear else {
            return
        }
        
        shownKeyboardOnceInitially = true
        codeInputField?.becomeFirstResponder()
    }
    
    private func showPasteMenu() {
        guard let codeInputField = codeInputField,
              var clipboardText = UIPasteboard.general.string else {
            return
        }
        
        for character in configuration.charactersToFilterOutOnPaste {
            clipboardText = clipboardText.replacingOccurrences(of: character, with: "")
        }
        
        guard configuration.codeLength == clipboardText.count,
              configuration.keyboardType != .numberPad || clipboardText.isNumber else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            return
        }
        
        codeInputField.becomeFirstResponder()
        UIMenuController.shared.showMenu(from: codeInputField, rect: codeInputField.frame)
    }
    
    private func handleEnteredCode() {
        enteredCode = code
        onEnteredCode()
    }
    
    private func handleResendCode() {
        code = ""
        onResendCode()
    }
    
    private func character(for index: Int) -> Character? {
        code.count > index ? code[code.index(code.startIndex, offsetBy: index)] : nil
    }
    
    private func placeholder(for index: Int) -> Character? {
        let text = configuration.placeholder
        return text.count > index ? text[text.index(text.startIndex, offsetBy: index)] : nil
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(
            code: .constant(""),
            forceCooldownOnce: .constant(false),
            configuration: .example,
            onEnteredCode: {},
            onResendCode: {}
        )
    }
}
