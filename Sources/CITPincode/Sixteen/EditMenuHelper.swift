//
//  File.swift
//  
//
//  Created by Lex Brouwers on 28/06/2022.
//

import SwiftUI

@available(iOS 16.0, *)
public class EditMenuHelper {
    public static var shared = EditMenuHelper()
    
    private let pasteActionMenu = PasteActionMenu()
    
    public func setupPasteEditMenu(for inputField: UITextField) {
        inputField.addInteraction(pasteActionMenu.editMenuInteraction)
    }
}

@available(iOS 16.0, *)
public class PasteActionMenu: NSObject, UIEditMenuInteractionDelegate {
    lazy var editMenuInteraction = UIEditMenuInteraction(delegate: self)
}
