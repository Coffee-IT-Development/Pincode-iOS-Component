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
    private var config: CITPincodeConfig
    private var onResendCode: () -> Void
    
    @StateObject private var cooldownTimer = CITPincodeCooldownTimer()
    
    private var style: CITPincodeResendButtonStyle {
        config.resendButtonStyle
    }
    
    public init(
        forceCooldownOnce: Binding<Bool>,
        config: CITPincodeConfig,
        onResendCode: @escaping () -> Void
    ) {
        _forceCooldownOnce = forceCooldownOnce
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
        .onChange(of: forceCooldownOnce) { forced in
            if forced {
                forceCooldownOnce = false
                activateCooldown()
            }
        }
    }
    
    private func resendCode() {
        activateCooldown()
        onResendCode()
    }
    
    private func activateCooldown() {
        cooldownTimer.current = style.cooldown.time
        cooldownTimer.restartTimer()
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
        let value = min(cooldownTimer.current, style.cooldown.time)
        return String(format: "(%.0f)", value)
    }
    
    var isOnCooldown: Bool {
        cooldownTimer.current > 0
    }
}

struct CITPincodeResendButton_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeResendButton(forceCooldownOnce: .constant(false), config: .example, onResendCode: {})
    }
}
