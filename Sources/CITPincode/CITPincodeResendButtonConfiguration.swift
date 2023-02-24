//
//  CITPincodeResendButtonConfiguration.swift
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

import SwiftUI

/// Defines the style that configures an optional resendButton that is meant to resend an One Time Passcode on press.
/// This resend button will be disabled for the given cooldown if any and automatically re-enable itself once the cooldown duration has passed.
/// - Use `.custom` to set `text, font, textColor, backgroundColor, contentInsets, cornerRadius, cooldown`.
/// - Use `.plain` to set `text, font, cooldown` and use default values for the other fields.
/// - Use `.none` when no resend button should be shown.
/// 
public enum CITPincodeResendButtonConfiguration: Equatable {
    case none
    case plain(text: String = CITPincodeResendButtonStyle.defaultText, font: Font = .system(size: 16), cooldown: CITPincodeResendCodeCooldown = .none)
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
