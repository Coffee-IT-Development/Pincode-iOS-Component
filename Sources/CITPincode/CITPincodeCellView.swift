//
//  CITPincodeCellView.swift
//  
//  MIT License
//
//  Copyright (c) 2022 Coffee IT
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI

struct CITPincodeCellView: View {
    let config: CITPincodeView.Configuration
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
            .frame(idealWidth: size.width, maxWidth: size.width)
            .frame(height: size.height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(selectedBorderColor, lineWidth: isSelected || config.alwaysShowSelectedBorder ? config.selectedBorderWidth : 0)
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
            config: .example,
            character: character,
            placeholder: placeholder,
            isSelected: isSelected,
            hasError: hasError
        )
    }
}
