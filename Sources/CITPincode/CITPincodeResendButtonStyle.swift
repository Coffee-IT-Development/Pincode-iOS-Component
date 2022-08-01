//
//  CITPincodeResendButtonStyle.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation
import SwiftUI

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
