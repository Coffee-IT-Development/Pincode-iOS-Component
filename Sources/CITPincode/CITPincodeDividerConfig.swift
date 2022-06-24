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
    case custom(style: CITPincodeDividerStyle)
}
