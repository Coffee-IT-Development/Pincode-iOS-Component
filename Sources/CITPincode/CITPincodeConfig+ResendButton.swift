//
//  CITPincodeConfig+ResendButton.swift
//  
//
//  Created by Lex Brouwers on 09/06/2022.
//

import SwiftUI

public extension CITPincodeConfig {
    var resendButtonStyle: (text: String, font: Font, textColor: Color, backgroundColor: Color, cooldown: ResendCodeCooldown) {
        switch resendButton {
        case let .custom(text, font, textColor, backgroundColor, cooldown):
            return (text, font, textColor, backgroundColor, cooldown)
        case let .plain(text, cooldown):
            return (text, font, textColor, backgroundColor, cooldown)
        case .none:
            return ("", font, textColor, backgroundColor, .none)
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
    
    var resendButtonView: some View {
        Button(action: resendCode) {
            Text(resendButtonText)
                .font(resendButtonStyle.font)
                .foregroundColor(resendButtonStyle.textColor)
        }
    }
    
    func resendCode() {
        
    }

    enum ResendButton {
        case none
        case plain(text: String = "Send code again", cooldown: ResendCodeCooldown = .none)
        case custom(text: String = "Send code again", font: Font, textColor: Color, backgroundColor: Color, cooldown: ResendCodeCooldown = .none)
    }
    
    enum ResendCodeCooldown {
        case none
        case duration(value: TimeInterval)
    }
}
