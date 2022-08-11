//
//  CITPincodeResendButtonConfiguration.swift
//  
//
//  Created by Lex Brouwers on 21/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

/// Defines the style that configures an optional resendButton that is meant to resend an One Time Passcode on press.
/// This resend button will be disabled for the given cooldown if any and automatically re-enable itself once the cooldown duration has passed.
/// - Use `.custom` to set `text, font, textColor, backgroundColor, contentInsets, cornerRadius, cooldown, alignment`.
/// - Use `.plain` to set `text, font, cooldown, alignment` and use default values for the other fields.
/// - Use `.none` when no resend button should be shown.
/// 
public enum CITPincodeResendButtonConfiguration: Equatable {
    case none
    case plain(text: String = "citpincode_resend_code_button_text".localized, font: Font = .system(size: 16), cooldown: CITPincodeResendCodeCooldown = .none, alignment: HorizontalAlignment = .leading)
    case custom(style: CITPincodeResendButtonStyle)

    var showButton: Bool {
        switch self {
        case .none:
            return false
        default:
            return true
        }
    }
}
