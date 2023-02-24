//
//  CITPincodeView.swift
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

/// The CITPincodeView provides a simple One Time Passcode interface with deep customization through its config.
/// It includes an optional resend code button with built-in cooldown logic, an error label that's dynamically shown and error color tints, callbacks for when a code has been entered and when the resend code button is pressed and long press to paste logic that filters hyphens and denies codes of the wrong type, e.g. pasting letters into a numeric code.
public struct CITPincodeView: View {
    @Binding var code: String
    @Binding var error: String?
    @Binding var forceCooldownOnce: Bool
    
    private let config: CITPincodeView.Configuration
    private let onEnteredCode: () -> Void
    private let onResendCode: () -> Void
    
    @State private var enteredCode = ""
    @State private var codeInputField: UITextField?
    @State private var shownKeyboardOnceInitially = false
    
    var hasError: Bool {
        error != nil
    }
    
    /// Intialise the pincode view with bindings, a config and callbacks.
    /// - Parameters:
    ///   - code: Text binding for code input.
    ///   - error: Optional error binding for displaying error messages below the pincode view and showing error tint colors.
    ///   - forceCooldownOnce: Used to trigger resendButton cooldown once whenever set to true. This may be useful if you'd like to manually send a code onAppear or any other moment, so that the resendButton goes on cooldown when appropriate.
    ///   - config: Used to configure various visual and functional aspects of the pincode view.
    ///   - onEnteredCode: Called when a code has been entered, i.e. "code.count" equals "config.codeLength".
    ///   - onResendCode: Called when the resend code button is pressed, the button is disabled on press for the given cooldown duration.
    public init(
        code: Binding<String>,
        error: Binding<String?> = .constant(nil),
        forceCooldownOnce: Binding<Bool>,
        config: CITPincodeView.Configuration,
        onEnteredCode: @escaping () -> Void,
        onResendCode: @escaping () -> Void
    ) {
        _code = code
        _error = error
        _forceCooldownOnce = forceCooldownOnce
        self.config = config
        self.onEnteredCode = onEnteredCode
        self.onResendCode = onResendCode
    }
    
    public var body: some View {
        VStack(alignment: config.overallAlignment, spacing: config.verticalSpacing) {
            HStack {
                ForEach(0 ..< config.codeLength, id: \.self) { index in
                    CITPincodeCellView(
                        config: config,
                        character: character(for: index),
                        placeholder: placeholder(for: index),
                        isSelected: index == code.count,
                        hasError: hasError
                    )
                    
                    if config.dividerStyle.afterIndex == index {
                        CITPincodeDivider(config: config)
                    }
                }
            }
            .background(
                GeometryReader { proxy in
                    CITPincodeTextField(
                        text: $code,
                        config: config,
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

            if config.resendButton.showButton {
                CITPincodeResendButton(
                    forceCooldownOnce: $forceCooldownOnce,
                    config: config,
                    action: handleResendCode
                )
                .accessibility(label: Text(config.resendButtonStyle.text))
            }
            
            optionalErrorLabel
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
    
    @ViewBuilder
    private var optionalErrorLabel: some View {
        if let error = error {
            Text(error)
                .foregroundColor(config.errorColor)
                .font(config.errorFont)
                .accessibility(label: Text(error))
        }
    }
    
    private func setupPasteOnlyTextField(_ textField: UITextField) {
        DispatchQueue.main.async {
            codeInputField = textField
            textField.addDoneButton(config.keyboardDoneButtonText)
            showKeyboardInitially()
        }
    }
    
    private func showKeyboardInitially() {
        guard !shownKeyboardOnceInitially && config.showKeyboardOnAppear else {
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
        
        for character in config.charactersToFilterOutOnPaste {
            clipboardText = clipboardText.replacingOccurrences(of: character, with: "")
        }
        
        guard config.codeLength == clipboardText.count,
              config.keyboardType != .numberPad || clipboardText.isNumber else {
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
        let text = config.placeholder
        return text.count > index ? text[text.index(text.startIndex, offsetBy: index)] : nil
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(
            code: .constant(""),
            forceCooldownOnce: .constant(false),
            config: .example,
            onEnteredCode: {},
            onResendCode: {}
        )
    }
}
