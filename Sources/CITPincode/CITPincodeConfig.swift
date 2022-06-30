//
//  File.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import Foundation
import SwiftUI

/// The CITPincodeConfig provides most of the static attributes of the CITPincodeView as a single object, incl. code length, fonts, colors, border settings, divider- and resendButton options.
/// It can also be used dynamically with @State if desired, e.g. to animate cellSize, cornerRadius or colors.
public struct CITPincodeConfig: Equatable {

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
    
    /// The size of each pincode cell.
    public var cellSize: CGSize
    
    /// The cornerRadius of each pincode cell, used to set rounded corners, e.g. set to 0 for sharp corners, to 8 for small rounding or .infinity for maximum rounding.
    public var cellCornerRadius: CGFloat
    
    /// The type of pincode, you can choose any UIKeyboardType, but the most common types are ".default" for a text keyboard and .numberPad for a numbers only keyboard.
    public var codeType: UIKeyboardType
    
    /// Optional config used to show a single divider somewhere between the pincode cells. Does not impact user input, and can be customised slightly.
    public var divider: CITPincodeDividerConfig
    
    /// Optional config used to show a resendButton, meant to resend an One Time Passcode on press and is automatically disabled for a given cooldown duration to limit usage.
    public var resendButton: CITPincodeResendButtonConfig
    
    public init(
        codeLength: Int = 6,
        font: Font = .system(size: 16),
        errorFont: Font? = nil,
        textColor: Color = .black,
        errorColor: Color = .red,
        placeholder: String = "",
        placeholderColor: Color? = nil,
        backgroundColor: Color = .init(white: 0.2),
        selectedBackgroundColor: Color? = nil,
        selectedBorderColor: Color? = nil,
        selectedBorderWidth: CGFloat = 1,
        alwaysShowSelectedBorder: Bool = false,
        showKeyboardOnAppear: Bool = true,
        cellSize: CGSize = .init(width: 40, height: 56),
        cellCornerRadius: CGFloat = 8,
        codeType: UIKeyboardType = .default,
        divider: CITPincodeDividerConfig = .none,
        resendButton: CITPincodeResendButtonConfig = .none
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
        self.cellSize = cellSize
        self.cellCornerRadius = cellCornerRadius
        self.codeType = codeType
        self.divider = divider
        self.resendButton = resendButton
    }
}

// MARK: - Resend Button

extension CITPincodeConfig {
    
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
}

// MARK: - Example Configurations

extension CITPincodeConfig {
    public static var socialBlox = CITPincodeConfig(
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
    
    public static var inlite = CITPincodeConfig(
        font: .system(size: 18),
        textColor: Color(#colorLiteral(red: 0.168627451, green: 0.2352941176, blue: 0.2745098039, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 1, green: 0.3333333333, blue: 0.4156862745, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)),
        cellSize: CGSize(width: 46, height: 60),
        cellCornerRadius: 6,
        resendButton: .plain(text: "Resend code", font: .system(size: 15), cooldown: .duration(value: 60), alignment: .trailing)
    )
    
    public static var workstead = CITPincodeConfig(
        codeLength: 5,
        font: .system(size: 14),
        textColor: Color(#colorLiteral(red: 0.09803921569, green: 0.3254901961, blue: 0.5764705882, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 0.937254902, green: 0.3137254902, blue: 0.3137254902, alpha: 1)),
        placeholder: "12345",
        placeholderColor: Color(#colorLiteral(red: 0.6392156863, green: 0.7294117647, blue: 0.831372549, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.6392156863, green: 0.7294117647, blue: 0.831372549, alpha: 1)),
        alwaysShowSelectedBorder: true,
        cellSize: CGSize(width: 40, height: 48),
        codeType: .numberPad
    )
    
    public static var babyManager = CITPincodeConfig(
        font: .system(size: 16),
        textColor: Color(#colorLiteral(red: 0.1215686275, green: 0.1960784314, blue: 0.3529411765, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 1, green: 0.2588235294, blue: 0.3921568627, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        cellSize: CGSize(width: 48, height: 48),
        codeType: .numberPad
    )
    
    public static var bagtag = CITPincodeConfig(
        font: .system(size: 16),
        textColor: Color(#colorLiteral(red: 0.1215686275, green: 0.1960784314, blue: 0.3529411765, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 0.937254902, green: 0.3137254902, blue: 0.3137254902, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.7725490196, green: 0.8039215686, blue: 0.8509803922, alpha: 1)),
        cellSize: CGSize(width: 46, height: 56),
        codeType: .default,
        divider: .custom(style: CITPincodeDividerStyle(afterIndex: 2, color: Color(#colorLiteral(red: 0.1215686275, green: 0.1960784314, blue: 0.3529411765, alpha: 1)), size: .init(width: 8, height: 2), cornerRadius: .infinity))
    )
}
