//
//  CITPincodeResendButtonStyle.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//

import Foundation
import SwiftUI

struct CITPincodeResendButtonStyle {
    var text: String = "Send code again"
    var font: Font
    var textColor: Color
    var backgroundColor: Color
    var contentInsets: EdgeInsets = CITPincodeResendButtonStyle.defaultContentInsets
    var cornerRadius: CGFloat = .infinity
    var cooldown: CITPincodeResendCodeCooldown = .none
    var alignment: HorizontalAlignment = .leading
    
    public static let defaultContentInsets: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
    public static let none = CITPincodeResendButtonStyle(font: .system(size: 14), textColor: .clear, backgroundColor: .clear)
}
