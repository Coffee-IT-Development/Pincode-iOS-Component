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
    @Binding private var forceCooldownOnce: Bool
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
    
    public init(
        forceCooldownOnce: Binding<Bool>,
        config: CITPincodeView.Configuration,
        action: @escaping () -> Void
    ) {
        _forceCooldownOnce = forceCooldownOnce
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
        .onChange(of: forceCooldownOnce) { forced in
            if forced {
                forceCooldownOnce = false
                activateCooldown()
            }
        }
    }
    
    private func resendCode() {
        activateCooldown()
        action()
    }
    
    private func activateCooldown() {
        cooldownTimer.secondsRemaining = style.cooldown.duration
        cooldownTimer.restartTimer()
    }
}

struct CITPincodeResendButton_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeResendButton(forceCooldownOnce: .constant(false), config: .example, action: {})
    }
}
