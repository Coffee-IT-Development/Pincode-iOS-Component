//
//  CITEditMenuHelper.swift
//  
//
//  Created by Lex Brouwers on 28/06/2022.
//

import SwiftUI

@available(iOS 16.0, *)
class CITEditMenuHelper {
    static var shared = CITEditMenuHelper()
    
    private let pasteActionMenu = PasteActionMenu()
    
    func setupPasteEditMenu(for inputField: UITextField) {
        inputField.addInteraction(pasteActionMenu.editMenuInteraction)
    }
    
    func showEditMenu(in frame: CGRect) {
        let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: .init(x: frame.midX, y: 0))
        pasteActionMenu.editMenuInteraction.presentEditMenu(with: configuration)
    }
}

@available(iOS 16.0, *)
class PasteActionMenu: NSObject, UIEditMenuInteractionDelegate {
    lazy var editMenuInteraction = UIEditMenuInteraction(delegate: self)
}
