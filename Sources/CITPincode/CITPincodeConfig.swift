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
    let codeType: CodeType
    let divider: Divider
    let resendButton: ResendButton
}

extension CITPincodeConfig {
    enum ResendButton {
        case none
        case plain(text: String = "Send code again", font: Font, cooldown: CITPincodeResendCodeCooldown = .none)
        case custom(style: CITPincodeResendButtonStyle)
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
        textColor: .white,
        errorColor: Color(#colorLiteral(red: 0.968627451, green: 0.4117647059, blue: 0.2901960784, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBackgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.5294117647, green: 0.5333333333, blue: 0.5411764706, alpha: 1)),
        cellSize: CGSize(width: 40, height: 56),
        cellCornerRadius: CornerRadius.small,
        codeType: .numeric,
        divider: .custom(afterIndex: 2, color: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)), size: .init(width: 8, height: 2), cornerRadius: .infinity),
        resendButton: .plain(font: .system(size: 16, weight: .bold), cooldown: .duration(value: 60))
    )
}
