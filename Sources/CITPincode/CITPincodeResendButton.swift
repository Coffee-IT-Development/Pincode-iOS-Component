//
//  CITPincodeResendButton.swift
//  
//  MIT License
//
//  Copyright (c) 2022 Coffee IT
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Combine
import SwiftUI

struct CITPincodeResendButton: View {
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
    
    init(
        forceCooldownOnce: Binding<Bool>,
        config: CITPincodeView.Configuration,
        action: @escaping () -> Void
    ) {
        _forceCooldownOnce = forceCooldownOnce
        self.config = config
        self.action = action
    }
    
    var body: some View {
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
