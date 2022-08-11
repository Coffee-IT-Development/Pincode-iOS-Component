//
//  CITPincodeCellView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct CITPincodeCellView: View {
    let configuration: CITPincodeView.Configuration
    let character: Character?
    let placeholder: Character?
    let isSelected: Bool
    let hasError: Bool
    
    private var font: Font {
        configuration.font
    }
    
    private var size: CGSize {
        configuration.cellSize
    }
    
    private var hasCharacter: Bool {
        character != nil
    }
    
    private var hasPlaceholder: Bool {
        placeholder != nil
    }
    
    private var foregroundColor: Color {
        if hasCharacter {
            return hasError ? configuration.errorColor : configuration.textColor
        } else if hasPlaceholder {
            return configuration.placeholderColor
        } else {
            return configuration.textColor
        }
    }
    
    private var backgroundColor: Color {
        isSelected ? configuration.selectedBackgroundColor : configuration.backgroundColor
    }
    
    private var selectedBorderColor: Color {
        hasError ? configuration.errorColor : configuration.selectedBorderColor
    }
    
    private var cornerRadius: CGFloat {
        configuration.cellCornerRadius
    }
    
    private var text: String {
        if let value = character ?? placeholder {
            return String(value)
        }
        return ""
    }
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(foregroundColor)
            .frame(idealWidth: size.width, maxWidth: size.width)
            .frame(height: size.height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(selectedBorderColor, lineWidth: isSelected || configuration.alwaysShowSelectedBorder ? configuration.selectedBorderWidth : 0)
            )
    }
}

struct CITPincodeCellView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            exampleCell(character: "A", isSelected: false)
            exampleCell(character: "B", isSelected: false)
            exampleCell(character: "C", isSelected: false)
            exampleCell(isSelected: true)
        }
    }
    
    private static func exampleCell(
        character: Character? = nil,
        placeholder: Character? = nil,
        isSelected: Bool,
        hasError: Bool = false
    ) -> CITPincodeCellView {
        CITPincodeCellView(
            configuration: .example,
            character: character,
            placeholder: placeholder,
            isSelected: isSelected,
            hasError: hasError
        )
    }
}
