//
//  UITextField+Done.swift
//  
//
//  Created by Lex Brouwers on 14/06/2022.
//

import UIKit

extension UITextField {
    public func addDoneButton() {
        let doneText = "Done"
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
    public func onDonePressed() {
        self.resignFirstResponder()
    }
    
    @objc
    public func customHandleLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard let gestureView = gesture.view, let superView = gestureView.superview else {
            return
        }
        
        let menuController = UIMenuController.shared
        
        guard !menuController.isMenuVisible, gestureView.canBecomeFirstResponder else {
            return
        }
        
        gestureView.becomeFirstResponder()
        
        menuController.menuItems = [
            UIMenuItem(
                title: "Paste",
                action: #selector(pasteFromClipboard)
            ),
        ]
        
        menuController.showMenu(from: superView, rect: gestureView.frame)
    }
    
    @objc
    public func pasteFromClipboard() {
        guard let clipboardText = UIPasteboard.general.string else {
            return
        }
        
        text = clipboardText
    }
}
