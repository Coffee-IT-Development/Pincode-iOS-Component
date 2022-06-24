//
//  File.swift
//  
//
//  Created by Lex Brouwers on 24/06/2022.
//

import SwiftUI

struct CITPincodePasteModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            Color.green
        )
    }
}

extension View {
    func pastable() -> some View {
        modifier(CITPincodePasteModifier())
    }
}

public struct MenuLabelRepresentable: UIViewRepresentable {
    
    public init() {}
    
    public func makeUIView(context: Context) -> MenuLabel {
        MenuLabel()
    }

    public func updateUIView(_ uiView: MenuLabel, context: Context) {
        
    }
}


public class MenuLabel: UILabel {
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPressed(_:))
            )
        )
    }
    
    // MARK: - Actions
    
    @objc internal func handleLongPressed(_ gesture: UILongPressGestureRecognizer) {
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
                action: #selector(handlePasteAction(_:))
            ),
        ]
        
        menuController.showMenu(from: superView, rect: gestureView.frame)
    }
    
    @objc internal func handlePasteAction(_ controller: UIMenuController) {
        self.text = UIPasteboard.general.string
    }
}
