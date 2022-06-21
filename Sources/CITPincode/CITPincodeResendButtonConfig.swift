//
//  File.swift
//  
//
//  Created by Lex Brouwers on 21/06/2022.
//

import SwiftUI

public enum CITPincodeResendButtonConfig: Equatable {
    case none
    case plain(text: String = "Send code again", font: Font, cooldown: CITPincodeResendCodeCooldown = .none, alignment: HorizontalAlignment = .leading)
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
