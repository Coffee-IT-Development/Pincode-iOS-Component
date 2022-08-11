//
//  CITPincodeDivider.swift
//  
//
//  Created by Lex Brouwers on 21/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public enum CITPincodeDividerConfiguration: Equatable {
    case none
    case plain(afterIndex: Int)
    case custom(style: CITPincodeDividerStyle)
}
