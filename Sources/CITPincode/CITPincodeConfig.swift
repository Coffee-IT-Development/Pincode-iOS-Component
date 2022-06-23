//
//  File.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import Foundation
import SwiftUI

public struct CITPincodeConfig: Equatable {
    public var codeLength: Int
    public var font: Font
    public var errorFont: Font
    public var textColor: Color
    public var errorColor: Color
    public var placeholder: String
    public var placeholderColor: Color
    public var backgroundColor: Color
    public var selectedBackgroundColor: Color
    public var selectedBorderColor: Color
    public var alwaysShowSelectedBorder: Bool
    public var cellSize: CGSize
    public var cellCornerRadius: CGFloat
    public var codeType: UIKeyboardType
    public var divider: CITPincodeDividerConfig
    public var resendButton: CITPincodeResendButtonConfig
    
    public init(
        codeLength: Int = 6,
        font: Font,
        errorFont: Font? = nil,
        textColor: Color,
        errorColor: Color,
        placeholder: String = "",
        placeholderColor: Color? = nil,
        backgroundColor: Color,
        selectedBackgroundColor: Color? = nil,
        selectedBorderColor: Color? = nil,
        alwaysShowSelectedBorder: Bool = false,
        cellSize: CGSize,
        cellCornerRadius: CGFloat = CornerRadius.small,
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
        self.alwaysShowSelectedBorder = alwaysShowSelectedBorder
        self.cellSize = cellSize
        self.cellCornerRadius = cellCornerRadius
        self.codeType = codeType
        self.divider = divider
        self.resendButton = resendButton
    }
}

extension CITPincodeConfig {
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
}

extension CITPincodeConfig {
    public static var socialBlox = CITPincodeConfig(
        font: .system(size: 28, weight: .bold),
        textColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 0.968627451, green: 0.4117647059, blue: 0.2901960784, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.5294117647, green: 0.5333333333, blue: 0.5411764706, alpha: 1)),
        cellSize: CGSize(width: 40, height: 56),
        cellCornerRadius: CornerRadius.small,
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
        cellCornerRadius: CornerRadius.smaller,
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
        divider: .custom(afterIndex: 2, color: Color(#colorLiteral(red: 0.1215686275, green: 0.1960784314, blue: 0.3529411765, alpha: 1)), size: .init(width: 8, height: 2), cornerRadius: .infinity)
    )
}
