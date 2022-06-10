//
//  CITPincodeResendCodeCooldown.swift
//  
//
//  Created by Lex Brouwers on 10/06/2022.
//

import Foundation

public enum CITPincodeResendCodeCooldown {
    case none
    case duration(value: TimeInterval)
    
    var time: CGFloat {
        switch self {
        case let .duration(value):
            return value
        default:
            return 0
        }
    }
}
