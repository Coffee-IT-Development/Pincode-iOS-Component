//
//  UITextField+Done.swift
//  
//
//  Created by Lex Brouwers on 14/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import UIKit

extension UITextField {
    public func addDoneButton(_ doneText: String) {
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect.init(
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
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc
    private func onDonePressed() {
        self.resignFirstResponder()
    }
}
