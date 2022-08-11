//
//  CITPincodeDividerConfiguration.swift
//  
//
//  Created by Lex Brouwers on 21/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

/// The style of a shown divider if any.
/// - Use `.custom` to set `afterIndex, color, size & cornerRadius`.
/// - Use `.plain` to set `afterIndex` and use default values for the other fields.
/// - Use `.none` when no divider should be shown.
/// 
public enum CITPincodeDividerConfiguration: Equatable {
    case none
    case plain(afterIndex: Int)
    case custom(style: CITPincodeDividerStyle)
}
