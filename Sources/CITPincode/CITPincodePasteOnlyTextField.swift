//
//  CITPincodePasteOnlyTextField.swift
//  
//
//  Created by Lex Brouwers on 01/07/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import UIKit

public class CITPincodePasteOnlyTextField: UITextField {
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        action == #selector(UIResponderStandardEditActions.paste(_:))
    }
}
