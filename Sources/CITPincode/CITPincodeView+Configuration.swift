//
//  CITPincodeView+Configuration.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation
import SwiftUI

extension CITPincodeView {
    
    /// The CITPincodeView+Configuration provides most of the static attributes of the CITPincodeView as a single object, incl. code length, fonts, colors, border settings, divider- and resendButton options.
    /// It can also be used dynamically with @State if desired, e.g. to animate cellSize, cornerRadius or colors.
    public struct Configuration: Equatable {
        
        /// The length of the pincode.
        /// Determines amount of shown pincode cells as well as how many characters have to be entered before the code is checked.
        public var codeLength: Int = 6
        
        /// The font used to display text within the pincode cells.
        public var font: Font = .system(size: 16)
        
        /// The font used to display the error message if any error is visible.
        public var errorFont: Font?
        
        /// The color of the text within the pincode cells.
        public var textColor: Color = .black
        
        /// The color of the error message if visible.
        public var errorColor: Color = .red
        
        /// An optional placeholder code, shown within the pincode cells, should be entire codeLength if displayed at all,
        /// each placeholder character individually checks if there's no input at its position, and will be shown if there's none.
        public var placeholder: String = ""
        
        /// The color of the shown placeholder text shown within cells if any.
        public var placeholderColor: Color?
        
        /// The background color of pincode cells.
        public var backgroundColor: Color = .init(white: 0.2)
        
        /// The background color of a pincode cell when it is currently selected, a cell is selected when that cell would be filled with the next entered pincode character.
        public var selectedBackgroundColor: Color?
        
        /// The border color of any selected pincode cell.
        public var selectedBorderColor: Color?
        
        /// The border width of any selected pincode cell.
        public var selectedBorderWidth: CGFloat = 1
        
        /// If set to true, all pincode cells will always be shown as if they are selected.
        public var alwaysShowSelectedBorder: Bool = false
        
        /// If set to true, the keyboard will show once the pincode view appears.
        public var showKeyboardOnAppear: Bool = true
        
        /// Text shown for the button that can close the keyboard from a toolbar.
        public var keyboardDoneButtonText: String = "citpincode_keyboard_done_button_text".localized
        
        /// The size of each pincode cell.
        public var cellSize: CGSize = .init(width: 40, height: 56)
        
        /// The cornerRadius of each pincode cell, used to set rounded corners, e.g. set to 0 for sharp corners, to 8 for small rounding or .infinity for maximum rounding.
        public var cellCornerRadius: CGFloat = 8
        
        /// The type of pincode, you can choose any UIKeyboardType, but the most common types are ".default" for a text keyboard and .numberPad for a numbers only keyboard.
        public var codeType: UIKeyboardType = .default
        
        /// Optional config used to show a single divider somewhere between the pincode cells. Does not impact user input, and can be customized slightly.
        public var divider: CITPincodeDividerConfig = .none
        
        /// Optional config used to show a resendButton, meant to resend an One Time Passcode on press and is automatically disabled for a given cooldown duration to limit usage.
        public var resendButton: CITPincodeResendButtonConfig = .none
        
        /// Returns the style that configures an optional resendButton that is meant to resend an One Time Passcode on press.
        /// This button will be disabled for the given cooldown if any and automatically re-enable itself once the cooldown duration has passed.
        /// - Use `.custom` to set `text, font, textColor, backgroundColor, contentInsets, cornerRadius, cooldown, alignment`.
        /// - Use `.plain` to set `text, font, cooldown, alignment` and use default values for the other fields.
        /// - Use `.none` when no resend button should be shown.
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
        
        /// The style of a shown divider if any.
        /// - Use `.custom` to set `afterIndex, color, size & cornerRadius`.
        /// - Use `.plain` to set `afterIndex` and use default values for the other fields.
        /// - Use `.none` when no divider should be shown.
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
        
        /// An example configuration, can be used to try out a CITPincodeView or provide previews.
        public static var example = CITPincodeView.Configuration(
            font: .system(size: 28, weight: .bold),
            textColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            errorColor: Color(#colorLiteral(red: 0.968627451, green: 0.4117647059, blue: 0.2901960784, alpha: 1)),
            backgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
            selectedBorderColor: Color(#colorLiteral(red: 0.5294117647, green: 0.5333333333, blue: 0.5411764706, alpha: 1)),
            cellSize: CGSize(width: 40, height: 56),
            cellCornerRadius: 8,
            codeType: .numberPad,
            divider: .none,
            resendButton: .plain(font: .system(size: 16, weight: .bold), cooldown: .duration(value: 60))
        )
    }
}
