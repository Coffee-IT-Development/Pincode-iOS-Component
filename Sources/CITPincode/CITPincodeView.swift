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
    var config: CITPincodeConfig
    var onEnteredCode: (String) -> Void
    
    @State private var enteredCode = ""
    @State private var hasError = false
    @State private var resentCodeTimestamp: Date? = nil
    @State private var codeInputField: UITextField?
    
    public init(
        code: Binding<String>,
        busyCheckingCode: Binding<Bool> = .constant(false),
        config: CITPincodeConfig,
        onEnteredCode: @escaping (String) -> Void
    ) {
        self._code = code
        self._busyCheckingCode = busyCheckingCode
        self.config = config
        self.onEnteredCode = onEnteredCode
    }
    
    public var body: some View {
        VStack(alignment: config.resendButtonStyle.alignment) {
            HStack {
                ForEach((0 ..< config.codeLength), id: \.self) { i in
                    CITPincodeCellView(
                        config: config,
                        character: character(for: i),
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
                CITPincodeResendButton(config: config)
            }
        }
        .onChange(of: code) { newValue in
            print("[TEST] \(#function): Change code: \(newValue)")
            if newValue.count == config.codeLength && newValue != enteredCode {
                handleEnteredCode()
            } else if newValue.count > config.codeLength {
                code = String(newValue.prefix(config.codeLength))
            }
        }
    }
    
    private func handleEnteredCode() {
        print("[TEST] \(#function): ENTER THAT CODE! \(code)")
        enteredCode = code
        onEnteredCode(code)
    }
    
    private func character(for index: Int) -> Character? {
        code.count > index ? code[code.index(code.startIndex, offsetBy: index)] : nil
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(code: .constant(""), config: .socialBlox, onEnteredCode: { _ in })
    }
}
