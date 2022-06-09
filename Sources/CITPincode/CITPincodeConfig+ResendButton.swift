//
//  CITPincodeConfig+ResendButton.swift
//  
//
//  Created by Lex Brouwers on 09/06/2022.
//

import Foundation
import SwiftUI

public extension CITPincodeConfig {
    var resendButtonStyle: (
        text: String,
        font: Font,
        textColor: Color,
        backgroundColor: Color,
        contentInsets: EdgeInsets,
        cornerRadius: CGFloat,
        cooldown: ResendCodeCooldown,
        alignment: HorizontalAlignment
    ) {
        switch resendButton {
        case let .custom(text, font, textColor, backgroundColor, contentInsets, cornerRadius, cooldown, alignment):
            return (text, font, textColor, backgroundColor, contentInsets, cornerRadius, cooldown, alignment)
        case let .plain(text, font, cooldown):
            return (text, font, textColor, backgroundColor, ResendButton.defaultContentInsets, .infinity, cooldown, .leading)
        case .none:
            return ("", font, textColor, backgroundColor, ResendButton.defaultContentInsets, .infinity, .none, .leading)
        }
    }
    
    var resendButtonText: String {
        switch resendButtonStyle.cooldown {
        case let .duration(time):
            // TODO: Use current time, e.g. time - currentTime.
            return "\(resendButtonStyle.text) \(time)"
        default:
            return resendButtonStyle.text
        }
    }
    
    var isOnCooldown: Bool {
        print("[TEST] \(#function): date: \(resentCodeTimestamp ?? Date()), timeSinceResend: \(Date().timeIntervalSince(resentCodeTimestamp ?? Date())), cooldown: \(resendButtonStyle.cooldown.time)")
        return Date().timeIntervalSince(resentCodeTimestamp ?? Date()) <= resendButtonStyle.cooldown.time
    }
    
    var resendButtonView: some View {
        Button(action: resendCode) {
            Text(resendButtonText)
                .font(resendButtonStyle.font)
                .foregroundColor(resendButtonStyle.textColor)
                .padding(resendButtonStyle.contentInsets)
                .background(resendButtonStyle.backgroundColor)
                .cornerRadius(resendButtonStyle.cornerRadius)
                .disabled(isOnCooldown)
        }
    }
    
    func resendCode() {
        resentCodeTimestamp = Date()
    }

    enum ResendButton {
        case none
        case plain(
            text: String = "Send code again",
            font: Font,
            cooldown: ResendCodeCooldown = .none
        )
        case custom(
            text: String = "Send code again",
            font: Font,
            textColor: Color,
            backgroundColor: Color,
            contentInsets: EdgeInsets = ResendButton.defaultContentInsets,
            cornerRadius: CGFloat = .infinity,
            cooldown: ResendCodeCooldown = .none,
            alignment: HorizontalAlignment = .leading
        )
        
        public static let defaultContentInsets: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
    }
    
    enum ResendCodeCooldown {
        case none
        case duration(value: TimeInterval)
        
        var time: CGFloat {
            switch self {
            case let .duration(value):
                return value
            default:
                return 0
            }
        }
    }
}
