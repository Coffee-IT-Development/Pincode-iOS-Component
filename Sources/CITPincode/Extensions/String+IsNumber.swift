//
//  String+IsNumber.swift
//  
//
//  Created by Lex Brouwers on 28/06/2022.
//

import Foundation

extension String  {
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
