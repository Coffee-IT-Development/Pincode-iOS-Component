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
    let isSelected: Bool
    let hasError: Bool
    
    private var font: Font {
        config.font
    }
    
    private var size: CGSize {
        config.cellSize
    }
    
    private var foregroundColor: Color {
        hasError ? config.errorColor : config.textColor
    }
    
    private var backgroundColor: Color {
        isSelected ? config.selectedBackgroundColor : config.backgroundColor
    }
    
    private var selectedBorderColor: Color {
        config.selectedBorderColor
    }
    
    private var cornerRadius: CGFloat {
        config.cellCornerRadius
    }
    
    private var text: String {
        if let character = character {
            return String(character)
        }
        return ""
    }
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(foregroundColor)
            .frame(width: size.width, height: size.height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(selectedBorderColor, lineWidth: isSelected ? 1 : 0)
            )
    }
}

extension CITPincodeCellView {
    static func exampleCell(character: Character? = nil, isSelected: Bool, hasError: Bool = false) -> CITPincodeCellView {
        CITPincodeCellView(
            config: .socialBlox,
            character: character,
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
