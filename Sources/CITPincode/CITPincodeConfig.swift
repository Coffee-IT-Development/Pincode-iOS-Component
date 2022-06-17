//
//  File.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import Foundation
import SwiftUI

public struct CITPincodeConfig {
    let codeLength: Int
    let font: Font
    let textColor: Color
    let errorColor: Color
    let backgroundColor: Color
    let selectedBackgroundColor: Color
    let selectedBorderColor: Color
    let cellSize: CGSize
    let cellCornerRadius: CGFloat
    let codeType: UIKeyboardType
    let divider: Divider
    let resendButton: ResendButton
}

extension CITPincodeConfig {
    enum ResendButton {
        case none
        case plain(text: String = "Send code again", font: Font, cooldown: CITPincodeResendCodeCooldown = .none)
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
    
    var resendButtonStyle: CITPincodeResendButtonStyle {
        switch resendButton {
        case let .custom(style):
            return style
        case let .plain(text, font, cooldown):
            return CITPincodeResendButtonStyle(
                text: text,
                font: font,
                textColor: textColor,
                backgroundColor: backgroundColor,
                cooldown: cooldown
            )
        case .none:
            return .none
        }
    }
}

extension CITPincodeConfig {
    public static var socialBlox = CITPincodeConfig(
        codeLength: 6,
        font: .system(size: 28, weight: .bold), // Font.custom(CITFont.Lato.bold.name, size: 28) & lineheight .size(24)
        textColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 0.968627451, green: 0.4117647059, blue: 0.2901960784, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBackgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.5294117647, green: 0.5333333333, blue: 0.5411764706, alpha: 1)),
        cellSize: CGSize(width: 40, height: 56),
        cellCornerRadius: CornerRadius.small,
        codeType: .numberPad,
        divider: .none,
        resendButton: .plain(font: .system(size: 16, weight: .bold), cooldown: .duration(value: 60))
    )
    
    public static var bagtag = CITPincodeConfig(
        codeLength: 6,
        font: .system(size: 16),
        textColor: Color(#colorLiteral(red: 0.1215686275, green: 0.1960784314, blue: 0.3529411765, alpha: 1)),
        errorColor: Color(#colorLiteral(red: 0.937254902, green: 0.3137254902, blue: 0.3137254902, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)),
        selectedBackgroundColor: Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.7725490196, green: 0.8039215686, blue: 0.8509803922, alpha: 1)),
        cellSize: CGSize(width: 46, height: 56),
        cellCornerRadius: CornerRadius.small,
        codeType: .default,
        divider: .custom(afterIndex: 2, color: Color(#colorLiteral(red: 0.1215686275, green: 0.1960784314, blue: 0.3529411765, alpha: 1)), size: .init(width: 8, height: 2), cornerRadius: .infinity),
        resendButton: .none
    )
}
