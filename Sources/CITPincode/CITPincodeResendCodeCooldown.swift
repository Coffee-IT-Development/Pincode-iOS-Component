//
//  CITPincodeResendCodeCooldown.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import UIKit

/// When the resendCode button is pressed, it is disabled for the given cooldown duration, can be none or any non-nil absolute value.
public enum CITPincodeResendCodeCooldown: Equatable {
    case none
    case duration(value: TimeInterval)
    
    var duration: CGFloat {
        switch self {
        case let .duration(value):
            return abs(value)
        default:
            return 0
        }
    }
}
