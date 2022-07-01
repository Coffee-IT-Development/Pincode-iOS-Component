//
//  CITPincodePasteOnlyTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//

import UIKit

public class CITPincodePasteOnlyTextField: UITextField {
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        super.canPerformAction(action, withSender: sender)
//        UIResponderStandardEditActions.
//
//        if action == #selector(UIResponderStandardEditActions.copy(_:)) ||
//                    action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
//                    action == #selector(UIResponderStandardEditActions.paste(_:))
//        {
//        }
    }
}
