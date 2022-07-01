//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI
import SwiftUIX // Can be removed when we only support iOS 14+

/// The CITPincodeView provides a simple One Time Passcode interface with deep customisation through its config.
/// It includes an optional resend code button with built-in cooldown logic, an error label that's dynamically shown and error color tints, callbacks for when a code has been entered and when the resend code button is pressed and long press to paste logic that filters hyphens and denies codes of the wrong type, e.g. pasting letters into a numeric code.
public struct CITPincodeView: View {
    @Binding var code: String
    @Binding var error: String?
    
    private let config: CITPincodeConfig
    private let onEnteredCode: (String) -> Void
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
    ///   - config: Used to configure various visual and functional aspects of the pincode view.
    ///   - onEnteredCode: Called when a code has been entered, i.e. "code.count" equals "config.codeLength".
    ///   - onResendCode: Called when the resend code button is pressed, the button is disabled on press for the given cooldown duration.
    public init(
        code: Binding<String>,
        error: Binding<String?> = .constant(nil),
        config: CITPincodeConfig,
        onEnteredCode: @escaping (String) -> Void,
        onResendCode: @escaping () -> Void
    ) {
        self._code = code
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
            .accessibility(label: Text("Pincode view"))
            .overlay(
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
                    config: config,
                    onResendCode: handleResendCode
                )
                .accessibility(label: Text("Resend Code"))
            }
            
            if let error = error {
                Text(error)
                    .foregroundColor(config.errorColor)
                    .font(config.errorFont)
                    .padding(.vertical, 8)
                    .accessibility(label: Text("Error hint"))
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
    
    private func setupPasteOnlyTextField(_ textField: UITextField) {
        DispatchQueue.main.async {
            codeInputField = textField
            textField.addDoneButton()
            setupEditMenu(for: textField)
            showKeyboardInitially()
        }
    }
    
    private func setupEditMenu(for textField: UITextField) {
        if #available(iOS 16.0, *) {
            CITEditMenuHelper.shared.setupPasteEditMenu(for: textField)
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
        
        clipboardText = clipboardText.replacingOccurrences(of: "-", with: "")
        guard config.codeLength == clipboardText.count,
              config.codeType != .numberPad || clipboardText.isNumber else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            return
        }
        
        codeInputField.becomeFirstResponder()
        if #available(iOS 16.0, *) {
            CITEditMenuHelper.shared.showEditMenu(in: codeInputField.frame)
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
            config: .example,
            onEnteredCode: { _ in },
            onResendCode: {}
        )
    }
}
