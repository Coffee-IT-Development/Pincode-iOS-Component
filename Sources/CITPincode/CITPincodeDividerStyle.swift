//
//  File.swift
//  
//
//  Created by Lex Brouwers on 24/06/2022.
//

import Foundation
import SwiftUI

public struct CITPincodeDividerStyle: Equatable {
    public var afterIndex: Int
    public var color: Color
    public var size: CGSize = CITPincodeDividerStyle.defaultSize
    public var cornerRadius: CGFloat = CITPincodeDividerStyle.defaultCornerRadius
    
    public static let defaultSize = CGSize(width: 8, height: 2)
    public static let defaultCornerRadius = CGFloat.infinity
    public static let none = CITPincodeDividerStyle(
        afterIndex: -1,
        color: .clear,
        size: .zero,
        cornerRadius: 0
    )
}
