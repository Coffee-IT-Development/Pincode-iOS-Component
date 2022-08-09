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
    private let action: () -> Void
    
    @StateObject private var cooldownTimer = CITPincodeCooldownTimer()
    
    private var style: CITPincodeResendButtonStyle {
        config.resendButtonStyle
    }
    
    private var resendButtonText: String {
        switch style.cooldown {
        case .duration:
            return isOnCooldown ? "\(style.text) \(timeString)" : style.text
        default:
            return style.text
        }
    }
    
    private var timeString: String {
        String(format: "(%.0f)", cooldownTimer.secondsRemaining)
    }
    
    private var isOnCooldown: Bool {
        cooldownTimer.secondsRemaining > 0
    }
    
    public init(config: CITPincodeView.Configuration, action: @escaping () -> Void) {
        self.config = config
        self.action = action
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
        action()
    }
}

struct CITPincodeResendButton_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeResendButton(config: .example, action: {})
    }
}
