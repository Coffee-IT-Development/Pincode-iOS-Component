//
//  CITPincodeResendButton.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Combine
import SwiftUI

public struct CITPincodeResendButton: View {
    private let config: CITPincodeView.Configuration
    private let onResendCode: () -> Void
    
    @StateObject private var cooldownTimer = CITPincodeCooldownTimer()
    
    private var style: CITPincodeResendButtonStyle {
        config.resendButtonStyle
    }
    
    public init(config: CITPincodeView.Configuration, onResendCode: @escaping () -> Void) {
        self.config = config
        self.onResendCode = onResendCode
    }
    
    public var body: some View {
        Button(action: resendCode) {
            Text(resendButtonText)
                .font(style.font)
                .foregroundColor(style.textColor)
                .padding(style.contentInsets)
                .background(style.backgroundColor)
                .cornerRadius(style.cornerRadius)
                .opacity(isOnCooldown ? 0.5 : 1.0)
        }
        .disabled(isOnCooldown)
    }
    
    private func resendCode() {
        cooldownTimer.secondsRemaining = style.cooldown.duration
        cooldownTimer.restartTimer()
        onResendCode()
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
        let value = min(cooldownTimer.secondsRemaining, style.cooldown.duration)
        return String(format: "(%.0f)", value)
    }
    
    var isOnCooldown: Bool {
        cooldownTimer.secondsRemaining > 0
    }
}

struct CITPincodeResendButton_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeResendButton(config: .example, onResendCode: {})
    }
}
