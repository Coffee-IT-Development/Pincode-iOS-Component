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
    var config: CITPincodeConfig
    var onEnteredCode: (String) -> Void
    var onResendCode: () -> Void
    
    @State private var enteredCode = ""
    @State private var codeInputField: UITextField?
    @State private var shownKeyboardOnce = false
    @State private var pasteActionMenu = PasteActionMenu()
    
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
                TextField("", text: $code)
                    .keyboardType(config.codeType)
                    .textContentType(.oneTimeCode)
                    .opacity(0)
                    .allowsHitTesting(false)
            )
            .introspectTextField { textField in
                codeInputField = textField
                codeInputField?.addDoneButton()
                showKeyboardInitially()
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
    
    private func showPasteMenu() {
        pasteActionMenu.setOnPaste(action: pasteFromClipboard)
        
        if let codeInputField = codeInputField {
            print("[TEST] YES! pincodeView found, show menu.")
            pasteActionMenu.showMenu(in: codeInputField)
        } else {
            print("[TEST] NO pincodeView found!")
        }
    }
    
    private func pasteFromClipboard() {
        guard let clipboardText = UIPasteboard.general.string else {
            return
        }
        
        code = clipboardText
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

public class PasteActionMenu {
    private var onPaste: (() -> Void)?
    private let menuController: UIMenuController
    
    public init() {
        menuController = UIMenuController.shared
        menuController.arrowDirection = UIMenuController.ArrowDirection.default
        
        let myMenuItems: [UIMenuItem] = [
            UIMenuItem(title: "Paste", action: #selector(pasteFromClipboard))
        ]
        
        menuController.menuItems = myMenuItems
    }
    
    @objc
    public func showMenu(in view: UIView) {
        menuController.showMenu(from: view, rect: .init(x: 100, y: 200, width: 300, height: 300))
    }
    
    public func setOnPaste(action: @escaping () -> Void) {
        onPaste = action
    }
    
//    @objc
//    public func customHandleLongPressed(_ gesture: UILongPressGestureRecognizer) {
//        guard let gestureView = gesture.view, let superView = gestureView.superview else {
//            return
//        }
//
//        let menuController = UIMenuController.shared
//
//        guard !menuController.isMenuVisible, gestureView.canBecomeFirstResponder else {
//            return
//        }
//
//        gestureView.becomeFirstResponder()
//
//        menuController.menuItems = [
//            UIMenuItem(
//                title: "Paste",
//                action: #selector(pasteFromClipboard)
//            ),
//        ]
//
//        menuController.showMenu(from: superView, rect: gestureView.frame)
//    }
//
    @objc
    public func pasteFromClipboard() {
        onPaste?()
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
