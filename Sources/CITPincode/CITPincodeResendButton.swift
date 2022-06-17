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
        case .duration(_):
            if isOnCooldown {
                return "\(style.text) \(timeString)"
            } else {
                return style.text
            }
        default:
            return style.text
        }
    }
    
    var timeString: String {
        let value = min(style.cooldown.time - timeSinceLastUse, style.cooldown.time)
        return String(format: "(%.0f)", value)
    }
    
    var timeSinceLastUse: CGFloat {
        Date().timeIntervalSince(resentCodeTimestamp ?? Date())
    }
    
    var isOnCooldown: Bool {
        return resentCodeTimestamp != nil && timeSinceLastUse <= style.cooldown.time
    }
}

struct CITPincodeResendButton_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeResendButton(config: .socialBlox, resentCodeTimestamp: .constant(nil))
    }
}
