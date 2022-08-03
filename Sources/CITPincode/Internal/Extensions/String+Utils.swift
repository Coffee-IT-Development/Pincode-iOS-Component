//
//  String+Utils.swift
//  
//
//  Created by Lex Brouwers on 28/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation

extension String  {
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .module, value: "", comment: "")
    }
    
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
