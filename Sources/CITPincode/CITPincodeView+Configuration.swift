//
//  CITPincodeView+Configuration.swift
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

extension CITPincodeView {
    
    /// The CITPincodeView+Configuration provides most of the static attributes of the CITPincodeView as a single object, incl. code length, fonts, colors, border settings, divider- and resendButton options.
    public struct Configuration: Equatable {
        
        /// The length of the pincode.
        /// Determines amount of shown pincode cells as well as how many characters have to be entered before the code is checked.
        public var codeLength: Int
        
        /// The font used to display text within the pincode cells.
        public var font: Font
        
        /// The font used to display the error message if any error is visible.
        public var errorFont: Font
        
        /// The color of the text within the pincode cells.
        public var textColor: Color
        
        /// The color of the error message if visible.
        public var errorColor: Color
        
        /// An optional placeholder code, shown within the pincode cells, should be entire codeLength if displayed at all,
        /// each placeholder character individually checks if there's no input at its position, and will be shown if there's none.
        public var placeholder: String
        
        /// The color of the shown placeholder text shown within cells if any.
        public var placeholderColor: Color
        
        /// The background color of pincode cells.
        public var backgroundColor: Color
        
        /// The background color of a pincode cell when it is currently selected, a cell is selected when that cell would be filled with the next entered pincode character.
        public var selectedBackgroundColor: Color
        
        /// The border color of any selected pincode cell.
        public var selectedBorderColor: Color
        
        /// The border width of any selected pincode cell.
        public var selectedBorderWidth: CGFloat
        
        /// If set to true, all pincode cells will always be shown as if they are selected.
        public var alwaysShowSelectedBorder: Bool
        
        /// If set to true, the keyboard will show once the pincode view appears.
        public var showKeyboardOnAppear: Bool
        
        /// Text shown for the button that can close the keyboard from a toolbar.
        public var keyboardDoneButtonText: String
        
        /// The size of each pincode cell.
        public var cellSize: CGSize
        
        /// The cornerRadius of each pincode cell, used to set rounded corners, e.g. set to 0 for sharp corners, to 8 for small rounding or .infinity for maximum rounding.
        public var cellCornerRadius: CGFloat

        /// The spacing between pincode cells.
        public var cellSpacing: CGFloat

        /// The type of pincode, you can choose any UIKeyboardType, but the most common types are ".default" for a text keyboard and .numberPad for a numbers only keyboard.
        public var keyboardType: UIKeyboardType
        
        /// These characters will be filtered out if a code is pasted via clipboard on long press. It replaces occurences with an empty string.
        public var charactersToFilterOutOnPaste: [String]
        
        /// Optional config used to show a single divider somewhere between the pincode cells. Does not impact user input, and can be customized slightly.
        public var divider: CITPincodeDividerConfiguration
        
        /// Optional config used to show a resendButton, meant to resend an One Time Passcode on press and is automatically disabled for a given cooldown duration to limit usage.
        public var resendButton: CITPincodeResendButtonConfiguration
        
        /// Returns the configured resendButtonStyle, used to display the resendButton if present.
        public var resendButtonStyle: CITPincodeResendButtonStyle {
            switch resendButton {
            case let .custom(style):
                return style
            case let .plain(text, font, cooldown, alignment):
                return CITPincodeResendButtonStyle(
                    text: text,
                    font: font,
                    textColor: textColor,
                    backgroundColor: backgroundColor,
                    cooldown: cooldown,
                    alignment: alignment
                )
            case .none:
                return .none
            }
        }
        
        /// Returns the configured dividerStyle, used to display the divider if present.
        public var dividerStyle: CITPincodeDividerStyle {
            switch divider {
            case let .custom(style):
                return style
            case let .plain(afterIndex):
                return CITPincodeDividerStyle(
                    afterIndex: afterIndex,
                    color: textColor
                )
            case .none:
                return .none
            }
        }
        
        public init(
            codeLength: Int                                     = 6,
            font: Font                                          = .system(size: 16),
            errorFont: Font?                                    = nil,
            textColor: Color                                    = .black,
            errorColor: Color                                   = .red,
            placeholder: String                                 = "",
            placeholderColor: Color?                            = nil,
            backgroundColor: Color                              = .init(white: 0.2),
            selectedBackgroundColor: Color?                     = nil,
            selectedBorderColor: Color?                         = nil,
            selectedBorderWidth: CGFloat                        = 1,
            alwaysShowSelectedBorder: Bool                      = false,
            showKeyboardOnAppear: Bool                          = true,
            keyboardDoneButtonText: String                      = "citpincode_keyboard_done_button_text".localized,
            cellSize: CGSize                                    = .init(width: 40, height: 56),
            cellCornerRadius: CGFloat                           = 8,
            cellSpacing: CGFloat                                = 8,
            keyboardType: UIKeyboardType                        = .default,
            charactersToFilterOutOnPaste: [String]              = ["-"],
            divider: CITPincodeDividerConfiguration             = .none,
            resendButton: CITPincodeResendButtonConfiguration   = .none
        ) {
            self.codeLength = codeLength
            self.font = font
            self.errorFont = errorFont ?? font
            self.textColor = textColor
            self.errorColor = errorColor
            self.placeholder = String(placeholder.prefix(codeLength))
            self.placeholderColor = placeholderColor ?? selectedBorderColor ?? textColor
            self.backgroundColor = backgroundColor
            self.selectedBackgroundColor = selectedBackgroundColor ?? backgroundColor
            self.selectedBorderColor = selectedBorderColor ?? backgroundColor
            self.selectedBorderWidth = selectedBorderWidth
            self.alwaysShowSelectedBorder = alwaysShowSelectedBorder
            self.showKeyboardOnAppear = showKeyboardOnAppear
            self.keyboardDoneButtonText = keyboardDoneButtonText
            self.cellSize = cellSize
            self.cellCornerRadius = cellCornerRadius
            self.cellSpacing = cellSpacing
            self.keyboardType = keyboardType
            self.charactersToFilterOutOnPaste = charactersToFilterOutOnPaste
            self.divider = divider
            self.resendButton = resendButton
        }
        
        /// An example configuration, can be used to try out a CITPincodeView or provide previews.
        public static var example = CITPincodeView.Configuration(
            font: .system(size: 28, weight: .bold),
            textColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            errorColor: Color(#colorLiteral(red: 0.968627451, green: 0.4117647059, blue: 0.2901960784, alpha: 1)),
            backgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
            selectedBorderColor: Color(#colorLiteral(red: 0.5294117647, green: 0.5333333333, blue: 0.5411764706, alpha: 1)),
            cellSize: CGSize(width: 40, height: 56),
            cellCornerRadius: 8,
            keyboardType: .numberPad,
            divider: .none,
            resendButton: .plain(font: .system(size: 16, weight: .bold), cooldown: .duration(value: 60), alignment: .leading)
        )
    }
}
