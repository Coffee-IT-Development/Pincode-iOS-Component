//
//  CITPincodeCell.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

struct CITPincodeCell: Identifiable {
    let id = UUID()
    let config: CITPincodeConfig
    var character: String
    var isSelected: Bool
}

extension CITPincodeCell {
    var font: Font {
        config.font
    }
    
    var size: CGSize {
        config.cellSize
    }
    
    var foregroundColor: Color {
        config.hasError ? config.errorColor : config.textColor
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
