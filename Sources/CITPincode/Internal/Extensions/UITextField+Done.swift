//
//  UITextField+Done.swift
//  
//
//  Created by Lex Brouwers on 14/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// Adds a done button to the UITextField so the user may close it at any time.
    /// A text-based textfield has a built-in return button, however a numberpad keyboard does not.
    /// - Parameter doneText: Button text to be displayed, e.g. "Done".
    func addDoneButton(_ doneText: String) {
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 50
            )
        )
        
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: doneText, style: .done, target: self, action: #selector(onDonePressed))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
    
    @objc
    private func onDonePressed() {
        resignFirstResponder()
    }
}
