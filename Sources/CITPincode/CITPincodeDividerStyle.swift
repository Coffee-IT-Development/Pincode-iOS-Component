//
//  CITPincodeDividerStyle.swift
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

import Foundation
import SwiftUI

public struct CITPincodeDividerStyle: Equatable {
    public static let defaultSize = CGSize(width: 8, height: 2)
    public static let defaultCornerRadius = CGFloat.infinity
    public static let none = CITPincodeDividerStyle(
        afterIndex: -1,
        color: .clear,
        size: .zero,
        cornerRadius: 0
    )
    
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
}
