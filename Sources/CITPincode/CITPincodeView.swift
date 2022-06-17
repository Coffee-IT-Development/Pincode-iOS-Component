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
    var config: CITPincodeConfig
    
    public init(code: Binding<String>, config: CITPincodeConfig) {
        self._code = code
        self.config = config
    }
    
    @State private var hasError = false
    @State private var resentCodeTimestamp: Date? = nil
    @State private var codeInputField: UITextField?
    
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
            print("[TEST] Code changed: \(code), newValue: \(newValue)")
            if newValue.count == config.codeLength {
                onEnteredCode()
            } else if newValue.count > config.codeLength {
                code = String(newValue.prefix(config.codeLength))
            }
            
        }
    }
    
    private func onEnteredCode() {
        // Notify code filled.
    }
    
    private func character(for index: Int) -> Character? {
        code.count > index ? code[code.index(code.startIndex, offsetBy: index)] : nil
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(code: .constant(""), config: .socialBlox)
    }
}
