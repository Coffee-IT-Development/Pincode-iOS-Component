//
//  CITPincodeResendButtonAlignment.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 16/08/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

enum CITPincodeResendButtonAlignment: String {
    case leading
    case trailing
    
    var position: HorizontalAlignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}
