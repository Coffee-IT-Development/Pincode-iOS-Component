//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

public struct CITPincodeView: View {
    @Binding var code: String
    var config: CITPincodeConfig
    
    @FocusState private var focus: Focusable?
    @State private var hasError: Bool = false
    @State private var resentCodeTimestamp: Date? = nil
    
    private enum Focusable: Hashable {
        case codeInput
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
                    .focused($focus, equals: .codeInput)
            )
            .onTapGesture {
                focus = .codeInput
            }
            
            if config.resendButton.showButton {
                CITPincodeResendButton(config: config, resentCodeTimestamp: $resentCodeTimestamp)
            }
        }
        .onTapGesture {
            focus = nil
        }
        .onChange(of: code) { newValue in
            if newValue.count == config.codeLength {
                onEnteredCode()
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
