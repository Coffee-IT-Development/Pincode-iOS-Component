//
//  CITPincodeResendButtonStyle.swift
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

import Foundation
import SwiftUI

public struct CITPincodeResendButtonStyle: Equatable {
    public static let defaultText = "citpincode_resend_code_button_text".localized
    public static let defaultContentInsets: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
    public static let none = CITPincodeResendButtonStyle(font: .system(size: 14), textColor: .clear, backgroundColor: .clear)
    
    public var text: String = CITPincodeResendButtonStyle.defaultText
    public var font: Font
    public var textColor: Color
    public var backgroundColor: Color
    public var contentInsets: EdgeInsets = CITPincodeResendButtonStyle.defaultContentInsets
    public var cornerRadius: CGFloat = .infinity
    public var cooldown: CITPincodeResendCodeCooldown = .none
}
