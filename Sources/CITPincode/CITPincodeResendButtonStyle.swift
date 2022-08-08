//
//  CITPincodeResendButtonStyle.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation
import SwiftUI

/// Defines the style that configures an optional resendButton that is meant to resend an One Time Passcode on press.
/// This resend button will be disabled for the given cooldown if any and automatically re-enable itself once the cooldown duration has passed.
/// - Use `.custom` to set `text, font, textColor, backgroundColor, contentInsets, cornerRadius, cooldown, alignment`.
/// - Use `.plain` to set `text, font, cooldown, alignment` and use default values for the other fields.
/// - Use `.none` when no resend button should be shown.
///
public struct CITPincodeResendButtonStyle: Equatable {
    public var text: String = "citpincode_resend_code_button_text".localized
    public var font: Font
    public var textColor: Color
    public var backgroundColor: Color
    public var contentInsets: EdgeInsets = CITPincodeResendButtonStyle.defaultContentInsets
    public var cornerRadius: CGFloat = .infinity
    public var cooldown: CITPincodeResendCodeCooldown = .none
    public var alignment: HorizontalAlignment = .leading
    
    public static let defaultContentInsets: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
    public static let none = CITPincodeResendButtonStyle(font: .system(size: 14), textColor: .clear, backgroundColor: .clear)
}
