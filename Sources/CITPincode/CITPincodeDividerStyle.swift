//
//  CITPincodeDividerStyle.swift
//  
//
//  Created by Lex Brouwers on 24/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation
import SwiftUI

/// The style of a shown divider if any.
/// - Use `.custom` to set `afterIndex, color, size & cornerRadius`.
/// - Use `.plain` to set `afterIndex` and use default values for the other fields.
/// - Use `.none` when no divider should be shown.
public struct CITPincodeDividerStyle: Equatable {
    public var afterIndex: Int
    public var color: Color
    public var size: CGSize
    public var cornerRadius: CGFloat
    
    public init(
        afterIndex: Int,
        color: Color,
        size: CGSize = CITPincodeDividerStyle.defaultSize,
        cornerRadius: CGFloat = CITPincodeDividerStyle.defaultCornerRadius
    ) {
        self.afterIndex = afterIndex
        self.color = color
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    public static let defaultSize = CGSize(width: 8, height: 2)
    public static let defaultCornerRadius = CGFloat.infinity
    public static let none = CITPincodeDividerStyle(
        afterIndex: -1,
        color: .clear,
        size: .zero,
        cornerRadius: 0
    )
}
