//
//  File.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import Foundation
import SwiftUI

struct CITPincodeConfig {
    let font: Font
    let textColor: Color
    let errorColor: Color
    let backgroundColor: Color
    let selectedBackgroundColor: Color
    let selectedBorderColor: Color
    let cellSize: CGSize
    let cellCornerRadius: CGFloat
        
    var hasError = false
    
    lazy var getForegroundColor: (CITPincodeCell) -> Color = getForegroundColor
    lazy var getBackgroundColor: (CITPincodeCell) -> Color = getBackgroundColor
    
    var cells: [CITPincodeCell] {
        []
    }
    
    func getForegroundColor(for cell: CITPincodeCell) -> Color {
        hasError ? errorColor : textColor
    }
    
    func getBackgroundColor(for cell: CITPincodeCell) -> Color {
        cell.isSelected ? selectedBackgroundColor : backgroundColor
    }
}

extension CITPincodeConfig {
    static var socialBlox = CITPincodeConfig(
        font: .system(size: 28, weight: .bold), // Font.custom(CITFont.Lato.bold.name, size: 28) & lineheight .size(24)
        textColor: .white,
        errorColor: Color(#colorLiteral(red: 0.968627451, green: 0.4117647059, blue: 0.2901960784, alpha: 1)),
        backgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBackgroundColor: Color(#colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2392156863, alpha: 1)),
        selectedBorderColor: Color(#colorLiteral(red: 0.5294117647, green: 0.5333333333, blue: 0.5411764706, alpha: 1)),
        cellSize: CGSize(width: 40, height: 56),
        cellCornerRadius: CornerRadius.small,
        getForegroundColor: { cell in
            // TODO: Check example custom color logic test
            cell.config.hasError ? .red : .green
        }
    )
}
