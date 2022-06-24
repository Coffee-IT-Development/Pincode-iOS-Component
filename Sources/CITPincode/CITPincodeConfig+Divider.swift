//
//  CITPincodeConfig+Divider.swift
//  
//
//  Created by Lex Brouwers on 09/06/2022.
//

import SwiftUI

public extension CITPincodeConfig {
    
    /// The style of a shown divider if any.
    /// - Use `.custom` to set `afterIndex, color, size & cornerRadius`.
    /// - Use `.plain` to set `afterIndex` and use default values for the other fields.
    /// - Use `.none` when no divider should be shown.
    var dividerStyle: (afterIndex: Int, color: Color, size: CGSize, cornerRadius: CGFloat) {
        switch divider {
        case let .custom(afterIndex, color, size, cornerRadius):
            return (afterIndex, color, size, cornerRadius)
        case let .plain(afterIndex):
            return (afterIndex, textColor, CITPincodeDividerConfig.defaultSize, CITPincodeDividerConfig.defaultCornerRadius)
        case .none:
            return (-1, .clear, .zero, 0)
        }
    }
    
    var dividerView: some View {
        RoundedRectangle(cornerRadius: dividerStyle.cornerRadius)
            .foregroundColor(dividerStyle.color)
            .frame(width: dividerStyle.size.width, height: dividerStyle.size.height)
    }
}
