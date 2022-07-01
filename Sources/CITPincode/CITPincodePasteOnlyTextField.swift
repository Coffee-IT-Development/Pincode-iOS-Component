//
//  CITPincodePasteOnlyTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//

import UIKit

class CITPincodePasteOnlyTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        action == #selector(paste(_:))
    }
}
