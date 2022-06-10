//
//  CITPincodeCell.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

public struct CITPincodeCell: Identifiable {
    public let id = UUID()
    public let config: CITPincodeConfig
    public var character: String
    public var isSelected: Bool
    public var hasError: Bool
}

extension CITPincodeCell {
    var font: Font {
        config.font
    }
    
    var size: CGSize {
        config.cellSize
    }
    
    var foregroundColor: Color {
        hasError ? config.errorColor : config.textColor
    }
    
    var backgroundColor: Color {
        isSelected ? config.selectedBackgroundColor : config.backgroundColor
    }
    
    var selectedBorderColor: Color {
        config.selectedBorderColor
    }
    
    var cornerRadius: CGFloat {
        config.cellCornerRadius
    }
}
