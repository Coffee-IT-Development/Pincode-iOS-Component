//
//  CITPincodeResendButton.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//

import Combine
import SwiftUI

struct CITPincodeResendButton: View {
    let config: CITPincodeConfig
    @StateObject private var cooldownTimer = ResendCooldownTimer()
    
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
                .opacity(isOnCooldown ? 0.5 : 1.0)
        }
        .disabled(isOnCooldown)
    }
    
    private func resendCode() {
        cooldownTimer.current = style.cooldown.time
        cooldownTimer.restartTimer()
    }
    
    class ResendCooldownTimer: ObservableObject {
        @Published var current: CGFloat = 0
        @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
        
        private var subscriptions: [AnyCancellable] = []
        
        func restartTimer() {
            cancelTimer()
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            timer?.sink { [self] _ in
                if current > 0 {
                    current -= 1
                } else {
                    cancelTimer()
                }
            }
            .store(in: &subscriptions)
        }
        
        private func cancelTimer() {
            timer?.upstream.connect().cancel()
        }
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
        CITPincodeResendButton(config: .socialBlox)
    }
}
