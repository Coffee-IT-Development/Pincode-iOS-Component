//
//  CITPincodeCellView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

struct CITPincodeCellView: View {
    let config: CITPincodeConfig
    let character: Character?
    let placeholder: Character?
    let isSelected: Bool
    let hasError: Bool
    
    private var font: Font {
        config.font
    }
    
    private var size: CGSize {
        config.cellSize
    }
    
    private var hasCharacter: Bool {
        character != nil
    }
    
    private var hasPlaceholder: Bool {
        placeholder != nil
    }
    
    private var foregroundColor: Color {
        if hasCharacter {
            return hasError ? config.errorColor : config.textColor
        } else if hasPlaceholder {
            return config.placeholderColor
        } else {
            return config.textColor
        }
    }
    
    private var backgroundColor: Color {
        isSelected ? config.selectedBackgroundColor : config.backgroundColor
    }
    
    private var selectedBorderColor: Color {
        hasError ? config.errorColor : config.selectedBorderColor
    }
    
    private var cornerRadius: CGFloat {
        config.cellCornerRadius
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
            .frame(idealWidth: size.width, maxWidth: size.width, idealHeight: size.height, maxHeight: size.height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(selectedBorderColor, lineWidth: isSelected || config.alwaysShowSelectedBorder ? config.selectedBorderWidth : 0)
            )
    }
}

extension CITPincodeCellView {
    static func exampleCell(character: Character? = nil, placeholder: Character? = nil, isSelected: Bool, hasError: Bool = false) -> CITPincodeCellView {
        CITPincodeCellView(
            config: .example,
            character: character,
            placeholder: placeholder,
            isSelected: isSelected,
            hasError: hasError
        )
    }
}

struct CITPincodeCellView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CITPincodeCellView.exampleCell(character: "A", isSelected: false)
            CITPincodeCellView.exampleCell(character: "B", isSelected: false)
            CITPincodeCellView.exampleCell(character: "C", isSelected: false)
            CITPincodeCellView.exampleCell(isSelected: true)
        }
    }
}
