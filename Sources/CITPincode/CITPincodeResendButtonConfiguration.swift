//
//  CITPincodeResendButtonConfiguration.swift
//  
//
//  Created by Lex Brouwers on 21/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public enum CITPincodeResendButtonConfiguration: Equatable {
    case none
    case plain(text: String = "citpincode_resend_code_button_text".localized, font: Font = .system(size: 16), cooldown: CITPincodeResendCodeCooldown = .none, alignment: HorizontalAlignment = .leading)
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
