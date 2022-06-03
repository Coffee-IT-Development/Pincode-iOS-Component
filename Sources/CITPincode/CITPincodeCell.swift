//
//  CITPincodeCell.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

struct CITPincodeCell {
    let config: CITPincodeConfig
    let character: String
    let isSelected: Bool
}

extension CITPincodeCell {
    var font: Font {
        config.font
    }
    
    var size: CGSize {
        config.cellSize
    }
    
    var foregroundColor: Color {
        config.getForegroundColor(for: self)
    }
    
    var backgroundColor: Color {
        config.getBackgroundColor(for: self)
    }
    
    var selectedBorderColor: Color {
        config.selectedBorderColor
    }
    
    var cornerRadius: CGFloat {
        config.cellCornerRadius
    }
}
