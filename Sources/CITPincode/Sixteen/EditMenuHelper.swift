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
    
    public func showEditMenu() {
//        let location = recognizer.location(in: self.view)
        let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: .zero)
        pasteActionMenu.editMenuInteraction.presentEditMenu(with: configuration)
    }
}

@available(iOS 16.0, *)
public class PasteActionMenu: NSObject, UIEditMenuInteractionDelegate {
    lazy var editMenuInteraction = UIEditMenuInteraction(delegate: self)
}
