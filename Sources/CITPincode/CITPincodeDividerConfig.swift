//
//  CITPincodeDivider.swift
//  
//
//  Created by Lex Brouwers on 21/06/2022.
//

import SwiftUI

public enum CITPincodeDividerConfig: Equatable {
    case none
    case plain(afterIndex: Int)
    case custom(afterIndex: Int, color: Color, size: CGSize = CITPincodeDividerConfig.defaultSize, cornerRadius: CGFloat = CITPincodeDividerConfig.defaultCornerRadius)
    
    public static let defaultSize = CGSize(width: 8, height: 2)
    public static let defaultCornerRadius = CGFloat.infinity
}
