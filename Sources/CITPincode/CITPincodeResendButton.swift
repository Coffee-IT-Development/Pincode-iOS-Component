//
//  CITPincodeResendButton.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//

import SwiftUI

struct CITPincodeResendButton: View {
    let config: CITPincodeConfig
    @Binding var resentCodeTimestamp: Date?
    
    var style: CITPincodeResendButtonStyle {
        config.resendButtonStyle
    }
    
    var body: some View {
        Button(action: resendCode) {
            Text(resendButtonText)
                .font(style.font)
                .foregroundColor(style.textColor)
                .padding(style.contentInsets)
                .background(style.backgroundColor)
                .cornerRadius(style.cornerRadius)
                .disabled(isOnCooldown)
                .opacity(isOnCooldown ? 0.5 : 1.0)
        }
    }
    
    private func resendCode() {
        resentCodeTimestamp = Date()
    }
}

extension CITPincodeResendButton {
    var resendButtonText: String {
        switch style.cooldown {
        case let .duration(time):
            // TODO: Use current time, e.g. time - currentTime.
            return "\(style.text) \(time)"
        default:
            return style.text
        }
    }
    
    var isOnCooldown: Bool {
        return resentCodeTimestamp != nil && Date().timeIntervalSince(resentCodeTimestamp ?? Date()) <= style.cooldown.time
    }
}

struct CITPincodeResendButton_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeResendButton(config: .socialBlox, resentCodeTimestamp: .constant(nil))
    }
}
