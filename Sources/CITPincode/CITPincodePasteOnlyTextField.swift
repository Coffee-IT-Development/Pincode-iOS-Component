//
//  CITPincodePasteOnlyTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//

import UIKit

public class CITPincodePasteOnlyTextField: UITextField {
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//            return false
//        }
        return super.canPerformAction(action, withSender: sender)
    }
}
